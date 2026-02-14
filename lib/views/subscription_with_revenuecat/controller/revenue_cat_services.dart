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

  // Public API Keys
  static const String apiKeyIos = 'appl_ILLaDoanqUTpIrVJxLoVOPjhXkt';
  static const String apiKeyAndroid = 'goog_dBpRdjHQbRYZTMNRwUETawBDqrF';

  static const String premiumEntitlement = 'premium';
  static const String offeringIdentifier = 'premium';

  final RxBool isPremium = false.obs;
  final RxBool isLoading = false.obs;
  final Rxn<Offerings> offerings = Rxn<Offerings>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await init();
  }

  /// Initialize RevenueCat SDK
  Future<void> init() async {
    try {
      if (kDebugMode) await Purchases.setLogLevel(LogLevel.debug);

      final config = PurchasesConfiguration(
        Platform.isIOS ? apiKeyIos : apiKeyAndroid,
      );

      await Purchases.configure(config);

      // Listen for subscription updates
      Purchases.addCustomerInfoUpdateListener((info) {
        _handleCustomerInfoUpdate(info);
      });

      await refreshStatus();
    } catch (e) {
      debugPrint('RevenueCat init error: $e');
    }
  }

  /// Refresh offerings and subscription info
  Future<void> refreshStatus() async {
    try {
      isLoading.value = true;

      // Get offerings
      offerings.value = await Purchases.getOfferings();

      // Warn if offering not found
      if (offerings.value?.current?.identifier != offeringIdentifier) {
        debugPrint('Warning: Current offering is not "$offeringIdentifier"');
      }

      // Get user info
      final info = await Purchases.getCustomerInfo();
      _handleCustomerInfoUpdate(info);
    } catch (e) {
      debugPrint('Error refreshing status: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Handle subscription updates including cancellation
  void _handleCustomerInfoUpdate(CustomerInfo info) {
    final entitlement = info.entitlements.all[premiumEntitlement];
    final active = entitlement?.isActive ?? false;

    // Update reactive status
    isPremium.value = active;

    if (kDebugMode) {
      debugPrint('Premium status updated: $active');
      debugPrint('Entitlement details: ${entitlement?.toString()}');
    }
  }

  /// Get localized price of monthly package
  String? getProductPrice() {
    try {
      final current = offerings.value?.current;
      if (current != null) {
        final monthlyPackage = current.availablePackages
            .firstWhere(
              (p) => p.packageType == PackageType.monthly,
          orElse: () => current.availablePackages.first,
        );
        return monthlyPackage.storeProduct.priceString;
      }

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

  /// Purchase monthly subscription
  Future<bool> purchaseMonthly() async {
    try {
      isLoading.value = true;

      final offering = offerings.value?.all[offeringIdentifier] ?? offerings.value?.current;
      if (offering == null || offering.availablePackages.isEmpty) {
        Get.snackbar("Error", "No products available to purchase.");
        return false;
      }

      // Monthly package
      final monthlyPackage = offering.availablePackages.firstWhere(
            (p) => p.packageType == PackageType.monthly,
        orElse: () => offering.availablePackages.first,
      );

      final result = await Purchases.purchasePackage(monthlyPackage);

      _handleCustomerInfoUpdate(result.customerInfo);

      if (isPremium.value) {
        Get.snackbar("Success", "Purchase completed!");
      }
      return isPremium.value;
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      if (code == PurchasesErrorCode.purchaseCancelledError) {
        debugPrint("Purchase cancelled by user.");
      } else {
        debugPrint("Purchase error: ${e.message}");
        Get.snackbar("Purchase Error", e.message ?? "Something went wrong.");
      }
      return false;
    } catch (e) {
      debugPrint("Unexpected purchase error: $e");
      Get.snackbar("Error", "Unexpected error occurred.");
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
      _handleCustomerInfoUpdate(info);

      if (isPremium.value) {
        Get.snackbar("Success", "Premium restored!");
      } else {
        Get.snackbar("Notice", "No active subscription found.");
      }
    } catch (e) {
      debugPrint("Restore error: $e");
      Get.snackbar("Error", "Failed to restore purchases.");
    } finally {
      isLoading.value = false;
    }
  }
}
