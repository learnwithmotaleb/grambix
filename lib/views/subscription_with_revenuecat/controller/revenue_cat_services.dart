import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// ================================
// RevenueCat Service
// ================================
class RevenueCatService extends GetxController {
  // Singleton
  static final RevenueCatService _instance = RevenueCatService._internal();
  factory RevenueCatService() => _instance;
  RevenueCatService._internal();

  // RevenueCat API keys
  static const String apiKeyIos = 'appl_ILLaDoanqUTpIrVJxLoVOPjhXkt';
  static const String apiKeyAndroid = 'goog_dBpRdjHQbRYZTMNRwUETawBDqrF';

  // Entitlement & Product IDs
  static const String premiumEntitlement = 'premium';
  static const String monthlySubscription = 'grambix_premium_monthly';

  // Reactive states
  final RxBool isPremium = false.obs;
  final RxBool isLoading = false.obs;
  final Rxn<Offerings> offerings = Rxn<Offerings>();
  CustomerInfo? _latestCustomerInfo;

  @override
  Future<void> onInit() async {
    super.onInit();
    await init();
    _setupListeners();
  }

  /// Initialize RevenueCat
  Future<void> init() async {
    try {
      if (kDebugMode) Purchases.setLogLevel(LogLevel.debug);

      PurchasesConfiguration configuration;
      if (Platform.isIOS) {
        configuration = PurchasesConfiguration(apiKeyIos);
      } else if (Platform.isAndroid) {
        configuration = PurchasesConfiguration(apiKeyAndroid);
      } else {
        return;
      }

      await Purchases.configure(configuration);
      await loadOfferings();
      await checkPremiumStatus();
    } catch (e) {
      if (kDebugMode) print('RevenueCat init error: $e');
    }
  }

  /// Load offerings from RevenueCat
  Future<void> loadOfferings() async {
    try {
      isLoading.value = true;
      final loaded = await Purchases.getOfferings();
      offerings.value = loaded;
    } catch (e) {
      if (kDebugMode) print('Error loading offerings: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Check premium entitlement
  Future<void> checkPremiumStatus() async {
    try {
      final info = await Purchases.getCustomerInfo();
      _latestCustomerInfo = info;
      _updatePremiumStatus(info);
    } catch (e) {
      if (kDebugMode) print('Error checking premium status: $e');
    }
  }

  /// Listen for entitlement updates
  void _setupListeners() {
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      _latestCustomerInfo = customerInfo;
      _updatePremiumStatus(customerInfo);
    });
  }

  void _updatePremiumStatus(CustomerInfo customerInfo) {
    final active =
        customerInfo.entitlements.all[premiumEntitlement]?.isActive ?? false;
    isPremium.value = active;
  }

  // -------------------------------
  // Show RevenueCat Native Paywall
  // -------------------------------
  // Future<void> showPaywall() async {
  //   try {
  //     if (offerings.value == null) {
  //       await loadOfferings();
  //     }
  //
  //     if (offerings.value?.current != null) {
  //       await Purchases.presentPaywall(); // Latest v5+ API
  //     } else if (Get.context != null) {
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(
  //         const SnackBar(content: Text("No offerings available")),
  //       );
  //     }
  //   } catch (e) {
  //     if (kDebugMode) print('Paywall error: $e');
  //     if (Get.context != null) {
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(
  //         SnackBar(content: Text('Paywall error: $e')),
  //       );
  //     }
  //   }
  // }

  // -------------------------------
  // Purchase a package manually (optional)
  // -------------------------------
  Future<bool> purchaseMonthly() async {
    try {
      final currentOffering = offerings.value?.current;
      if (currentOffering == null || currentOffering.availablePackages.isEmpty) {
        return false;
      }

      final pkg = currentOffering.availablePackages.firstWhereOrNull(
              (p) => p.storeProduct.identifier == monthlySubscription);

      if (pkg == null) return false;

      final result = await Purchases.purchasePackage(pkg);
      final active = result.customerInfo
          ?.entitlements.all[premiumEntitlement]?.isActive ??
          false;
      _latestCustomerInfo = result.customerInfo;
      _updatePremiumStatus(_latestCustomerInfo!);
      return active;
    } catch (e) {
      if (kDebugMode) print('Purchase error: $e');
      return false;
    }
  }

  // -------------------------------
  // Restore purchases
  // -------------------------------
  Future<bool> restorePurchases() async {
    try {
      final info = await Purchases.restorePurchases();
      _latestCustomerInfo = info;
      _updatePremiumStatus(info);
      return info.entitlements.all[premiumEntitlement]?.isActive ?? false;
    } catch (e) {
      if (kDebugMode) print('Restore error: $e');
      return false;
    }
  }

  // -------------------------------
  // Get product price for UI
  // -------------------------------
  String? getProductPrice(String productId) {
    final pkgs = offerings.value?.current?.availablePackages ?? [];
    final pkg =
    pkgs.firstWhereOrNull((p) => p.storeProduct.identifier == productId);
    return pkg?.storeProduct.priceString;
  }
}

// -------------------------------
// Extension method for firstWhereOrNull
// -------------------------------
extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}


