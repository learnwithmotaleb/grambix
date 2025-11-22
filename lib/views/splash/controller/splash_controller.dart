import 'package:get/get.dart';
import 'package:grambix/core/utils/app_storage.dart';
import '../../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    Future.delayed(Duration(seconds: 5), () {
      if (AppStorage.isLoggedIn) {
        Get.toNamed(Routes.navigation);
      } else {
        Get.toNamed(Routes.navigation);
      }
    });
  }
}
