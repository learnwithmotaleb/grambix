import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart'; // Required for PlatformException
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService extends GetxController {
  static final RevenueCatService _instance = RevenueCatService._internal();
  factory RevenueCatService() => _instance;
  RevenueCatService._internal();

  // Your verified Public API Keys
  static const String apiKeyIos = 'appl_ILLaDoanqUTpIrVJxLoVOPjhXkt';
  static const String apiKeyAndroid = 'goog_dBpRdjHQbRYZTMNRwUETawBDqrF';

  static const String premiumEntitlement = 'premium';

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

      await Purchases.configure(config);

      // Listen for background updates (renewals/cancellations)
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

      // Fetch available products defined in RevenueCat Dashboard
      offerings.value = await Purchases.getOfferings();

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
    final active = info.entitlements.all[premiumEntitlement]?.isActive ?? false;
    isPremium.value = active;
  }

  /// Helper to get localized price (e.g., "$9.99" or "£8.99")
  String? getProductPrice() {
    // Tries to get the monthly package from the current offering
    final monthly = offerings.value?.current?.monthly;
    return monthly?.storeProduct.priceString;
  }

  /// Trigger Purchase for the Monthly Package
  Future<bool> purchaseMonthly() async {
    try {
      isLoading.value = true;

      // 1. Get the current offering (set as 'current' in dashboard)
      final currentOffering = offerings.value?.current;

      // 2. Get the specific monthly package
      final package = currentOffering?.monthly;

      if (package != null) {
        // 3. Execute purchase
        final result = await Purchases.purchasePackage(package);
        _updatePremiumStatus(result.customerInfo);
        return isPremium.value;
      } else {
        debugPrint("Error: Monthly package not found in current offering.");
        Get.snackbar("Configuration Error", "Store products are not ready yet.");
        return false;
      }
    } on PlatformException catch (e) {
      // Handle cancellation vs actual errors
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        debugPrint("User cancelled the purchase.");
      } else {
        Get.snackbar("Purchase Error", e.message ?? "Something went wrong.");
      }
      return false;
    } catch (e) {
      debugPrint("Unexpected error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Restore previous purchases (Mandatory for App Store)
  Future<void> restorePurchases() async {
    try {
      isLoading.value = true;
      final info = await Purchases.restorePurchases();
      _updatePremiumStatus(info);

      if (isPremium.value) {
        Get.snackbar("Restored", "Your premium access has been restored.");
      } else {
        Get.snackbar("Notice", "No active subscriptions found to restore.");
      }
    } catch (e) {
      Get.snackbar("Restore Error", "Failed to communicate with the store.");
    } finally {
      isLoading.value = false;
    }
  }
}