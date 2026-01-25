import 'package:get/get.dart';
import 'package:grambix/core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../../subscription_with_revenuecat/controller/revenue_cat_services.dart';

class SplashController extends GetxController {
  @override
  Future<void> onReady()  async {
    super.onReady();

    // // ScreenUtil mandatory
    // await ScreenUtil.ensureScreenSize();

    // final rev = Get.put(RevenueCatService(), permanent: true);
    // await rev.init();

    Future.delayed(Duration(seconds: 5), () {
      if (AppStorage.isLoggedIn) {
        Get.toNamed(Routes.navigation);
      } else {
        Get.toNamed(Routes.loginScreen);
      }
    });
  }
}
