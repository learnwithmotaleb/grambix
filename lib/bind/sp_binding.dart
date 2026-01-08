import 'package:get/get.dart';
import '../views/subscription_with_revenuecat/controller/sp_controller.dart';

class SpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpController>(() => SpController());
  }
}
