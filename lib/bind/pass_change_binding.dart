import 'package:get/get.dart';
import '../views/pass_change/controller/pass_change_controller.dart';

class PassChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassChangeController>(() => PassChangeController());
  }
}
