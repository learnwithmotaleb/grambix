import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

enum SubscriptionType { monthly, yearly, lifetime }

class RevenueCatService extends GetxController {
  // Singleton
  static final RevenueCatService _instance = RevenueCatService._internal();
  factory RevenueCatService() => _instance;
  RevenueCatService._internal();

  // RevenueCat API keys
  static final String apiKeyIos = const String.fromEnvironment(
      'REVENUECAT_IOS',
      defaultValue: 'appl_ILLaDoanqUTpIrVJxLoVOPjhXkt');
  static final String apiKeyAndroid = const String.fromEnvironment(
      'REVENUECAT_ANDROID',
      defaultValue: 'goog_dBpRdjHQbRYZTMNRwUETawBDqrF');

  // Entitlement & Product IDs
  static const String premiumEntitlement = 'premium';
  static const String monthlySubscription = 'grambix_premium_monthly';
  // Add yearly/lifetime IDs if created
  // static const String yearlySubscription = 'grambix_premium_yearly';
  // static const String lifetimePurchase = 'grambix_lifetime';

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

      if (kIsWeb) return;

      PurchasesConfiguration configuration;
      if (Platform.isIOS) {
        configuration = PurchasesConfiguration(apiKeyIos);
      } else if (Platform.isAndroid) {
        configuration = PurchasesConfiguration(apiKeyAndroid);
      } else {
        return;
      }

      await Purchases.configure(configuration);
      await _loadOfferings();
      await _checkPremiumStatus();

      if (kDebugMode) print('RevenueCat initialized.');
    } catch (e, st) {
      if (kDebugMode) print('RevenueCat init error: $e\n$st');
    }
  }

  Future<void> _loadOfferings() async {
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

  Future<void> _checkPremiumStatus() async {
    try {
      final info = await Purchases.getCustomerInfo();
      _latestCustomerInfo = info;
      _updatePremiumStatus(info);
    } catch (e) {
      if (kDebugMode) print('Error checking premium status: $e');
    }
  }

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

  /// --- SIMPLE PURCHASE METHOD ---
  Future<bool> purchaseProduct(SubscriptionType type) async {
    try {
      final currentOffering = offerings.value?.current;
      if (currentOffering == null || currentOffering.availablePackages.isEmpty) {
        return false;
      }

      String productId;
      switch (type) {
        case SubscriptionType.monthly:
          productId = monthlySubscription;
          break;
        case SubscriptionType.yearly:
        case SubscriptionType.lifetime:
          throw UnimplementedError();
      }

      final pkg = currentOffering.availablePackages
          .firstWhereOrNull((p) => p.storeProduct.identifier == productId);

      if (pkg == null) return false;

      final purchaseResult = await Purchases.purchasePackage(pkg);
      final active = purchaseResult.customerInfo
          ?.entitlements.all[premiumEntitlement]?.isActive ??
          false;
      _latestCustomerInfo = purchaseResult.customerInfo;
      _updatePremiumStatus(_latestCustomerInfo!);
      return active;
    } catch (e) {
      return false;
    }
  }

  /// --- DETAILED PURCHASE (OPTIONAL) ---
  Future<Map<String, dynamic>> purchaseProductDetailed(
      SubscriptionType type) async {
    try {
      final currentOffering = offerings.value?.current;
      if (currentOffering == null || currentOffering.availablePackages.isEmpty) {
        return {'success': false, 'error': 'No offerings available'};
      }

      String productId;
      switch (type) {
        case SubscriptionType.monthly:
          productId = monthlySubscription;
          break;
        case SubscriptionType.yearly:
        case SubscriptionType.lifetime:
          throw UnimplementedError();
      }

      final pkg = currentOffering.availablePackages
          .firstWhereOrNull((p) => p.storeProduct.identifier == productId);

      if (pkg == null) return {'success': false, 'error': 'Product not found'};

      final purchaseResult = await Purchases.purchasePackage(pkg);
      final ci = purchaseResult.customerInfo;

      if (ci != null) {
        _latestCustomerInfo = ci;
        _updatePremiumStatus(ci);
        final success =
            ci.entitlements.all[premiumEntitlement]?.isActive ?? false;
        return {
          'success': success,
          'error': success ? null : 'Entitlement not active',
          'customerInfo': ci
        };
      }

      return {'success': false, 'error': 'Purchase cancelled'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<bool> restorePurchases() async {
    try {
      final info = await Purchases.restorePurchases();
      _latestCustomerInfo = info;
      _updatePremiumStatus(info);
      return info.entitlements.all[premiumEntitlement]?.isActive ?? false;
    } catch (e) {
      return false;
    }
  }

  Package? getPackageById(String productId) {
    final pkgs = offerings.value?.current?.availablePackages ?? [];
    return pkgs.firstWhereOrNull((p) => p.storeProduct.identifier == productId);
  }

  String? getProductPrice(String productId) {
    return getPackageById(productId)?.storeProduct.priceString;
  }

  Stream<bool> get premiumStream => isPremium.stream;
}

// Extension method for `firstWhereOrNull`
extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final e in this) if (test(e)) return e;
    return null;
  }
}
