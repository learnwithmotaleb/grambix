import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../core/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../controller/revenue_cat_services.dart';

class SpController extends GetxController {
  final RevenueCatService _rev = Get.find<RevenueCatService>();

  final RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
    _listenSubscriptionUpdates();
  }

  /// Initial refresh & navigation check
  void _initialize() async {
    await _rev.refreshStatus();
    isInitialized.value = true;

    _redirectIfPremium();
  }

  /// Listen for subscription changes (including cancellation)
  void _listenSubscriptionUpdates() {
    Purchases.addCustomerInfoUpdateListener((info) {

      // Redirect to paywall if subscription is canceled
      if (!_rev.isPremium.value && Get.currentRoute != Routes.spScreen) {
        Get.offAllNamed(Routes.spScreen);
      }

      // Redirect to main app if subscription activated
      _redirectIfPremium();
    });
  }

  /// Navigate to main app if user is premium
  void _redirectIfPremium() {
    if (_rev.isPremium.value && Get.currentRoute != Routes.navigation) {
      Get.offAllNamed(Routes.navigation);
    }
  }

  /// Trigger purchase
  Future<void> purchase() async {
    bool success = await _rev.purchaseMonthly();
    if (success) {
      Get.snackbar(
        "Success",
        "Welcome to Premium!",
        backgroundColor: CustomColor.primary,
        colorText: Colors.white,
      );
      _redirectIfPremium();
    }
  }

  /// Restore previous purchases
  Future<void> restore() async {
    await _rev.restorePurchases();
    _redirectIfPremium();
  }

  /// Refresh subscription status manually
  Future<void> refresh() async {
    await _rev.refreshStatus();
    _redirectIfPremium();
  }
}
