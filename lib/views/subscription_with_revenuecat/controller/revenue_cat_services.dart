import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService extends GetxController {
  static final RevenueCatService _instance = RevenueCatService._internal();
  factory RevenueCatService() => _instance;
  RevenueCatService._internal();

  // Your verified Public API Keys
  static const String apiKeyIos = 'appl_ILLaDoanqUTpIrVJxLoVOPjhXkt';
  static const String apiKeyAndroid = 'goog_dBpRdjHQbRYZTMNRwUETawBDqrF';

  static const String premiumEntitlement = 'premium';
  static const String offeringIdentifier = 'premium'; // Offering ID from RevenueCat

  final RxBool isPremium = false.obs;
  final RxBool isLoading = false.obs;
  final Rxn<Offerings> offerings = Rxn<Offerings>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await init();
  }

  /// Initialize SDK and sync status
  Future<void> init() async {
    try {
      if (kDebugMode) await Purchases.setLogLevel(LogLevel.debug);

      final config = PurchasesConfiguration(
        Platform.isIOS ? apiKeyIos : apiKeyAndroid,
      );

      // Set user ID if you have one (optional)
      // await Purchases.setAppUserID("custom_user_id");

      await Purchases.configure(config);

      // Listen for background updates
      Purchases.addCustomerInfoUpdateListener((info) {
        _updatePremiumStatus(info);
      });

      await refreshStatus();
    } catch (e) {
      debugPrint('RevenueCat configuration error: $e');
    }
  }

  /// Fetch latest offerings and user subscription info
  Future<void> refreshStatus() async {
    try {
      isLoading.value = true;

      // Fetch available products
      offerings.value = await Purchases.getOfferings();

      // Check if we have the specific offering
      if (offerings.value?.current?.identifier != offeringIdentifier) {
        debugPrint('Warning: Current offering is not "$offeringIdentifier"');
      }

      // Fetch user entitlement status
      final info = await Purchases.getCustomerInfo();
      _updatePremiumStatus(info);
    } catch (e) {
      debugPrint('Error refreshing status: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Internal logic to check if 'premium' is active
  void _updatePremiumStatus(CustomerInfo info) {
    final entitlement = info.entitlements.all[premiumEntitlement];
    final active = entitlement?.isActive ?? false;
    isPremium.value = active;

    if (kDebugMode) {
      debugPrint('Premium status: $active');
      debugPrint('Entitlement data: ${entitlement?.toString()}');
    }
  }

  /// Get localized price for the monthly package
  String? getProductPrice() {
    try {
      // Try current offering first
      final current = offerings.value?.current;
      if (current != null) {
        // Look for monthly package
        for (final package in current.availablePackages) {
          if (package.packageType == PackageType.monthly) {
            return package.storeProduct.priceString;
          }
        }

        // If no monthly package found, get first available package
        if (current.availablePackages.isNotEmpty) {
          return current.availablePackages.first.storeProduct.priceString;
        }
      }

      // Fallback to specific offering if current doesn't work
      final premiumOffering = offerings.value?.all[offeringIdentifier];
      if (premiumOffering?.availablePackages?.isNotEmpty == true) {
        return premiumOffering!.availablePackages!.first.storeProduct.priceString;
      }

      return null;
    } catch (e) {
      debugPrint('Error getting product price: $e');
      return null;
    }
  }

  /// Trigger Purchase
  Future<bool> purchaseMonthly() async {
    try {
      isLoading.value = true;

      // 1. Get the offering
      final offering = offerings.value?.all[offeringIdentifier] ?? offerings.value?.current;

      if (offering == null) {
        debugPrint("Error: No offering found");
        Get.snackbar("Error", "Store configuration issue. Please try again later.");
        return false;
      }

      // 2. Find monthly package
      Package? monthlyPackage;
      for (final package in offering.availablePackages) {
        if (package.packageType == PackageType.monthly) {
          monthlyPackage = package;
          break;
        }
      }

      // If no monthly found, use first available package
      monthlyPackage ??= offering.availablePackages.isNotEmpty
          ? offering.availablePackages.first
          : null;

      if (monthlyPackage != null) {
        // 3. Execute purchase
        final result = await Purchases.purchasePackage(monthlyPackage);
        _updatePremiumStatus(result.customerInfo);

        if (isPremium.value) {
          Get.snackbar("Success", "Purchase completed!");
        }
        return isPremium.value;
      } else {
        debugPrint("Error: No packages found in offering");
        Get.snackbar("Configuration Error", "No products available for purchase.");
        return false;
      }
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        debugPrint("User cancelled the purchase.");
      } else {
        debugPrint("Purchase error: ${e.message}");
        Get.snackbar("Purchase Error", e.message ?? "Something went wrong.");
      }
      return false;
    } catch (e) {
      debugPrint("Unexpected error: $e");
      Get.snackbar("Error", "An unexpected error occurred.");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Restore previous purchases
  Future<void> restorePurchases() async {
    try {
      isLoading.value = true;
      final info = await Purchases.restorePurchases();
      _updatePremiumStatus(info);

      if (isPremium.value) {
        Get.snackbar("Success", "Your premium access has been restored.");
      } else {
        Get.snackbar("Notice", "No active subscriptions found.");
      }
    } catch (e) {
      debugPrint("Restore error: $e");
      Get.snackbar("Error", "Failed to restore purchases.");
    } finally {
      isLoading.value = false;
    }
  }
}