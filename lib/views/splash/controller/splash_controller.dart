import 'package:get/get.dart';
import 'package:grambix/core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../../subscription_with_revenuecat/controller/revenue_cat_services.dart';

class SplashController extends GetxController {
  final RevenueCatService _rev = Get.find<RevenueCatService>();

  @override
  Future<void> onReady() async {
    super.onReady();
    await _startAppFlow();
  }

  Future<void> _startAppFlow() async {
    // Optional splash delay
    await Future.delayed(const Duration(seconds: 2));

    // 1️⃣ Check login first
    if (!AppStorage.isLoggedIn) {
      Get.offAllNamed(Routes.loginScreen);
      return;
    }

    // 2️⃣ If logged in → refresh subscription
    await _rev.refreshStatus();

    // 3️⃣ Navigate based on subscription
    if (_rev.isPremium.value) {
      Get.offAllNamed(Routes.navigation); // Home
    } else {
      Get.offAllNamed(Routes.freeTrialScreen); // Paywall
    }
  }
}
