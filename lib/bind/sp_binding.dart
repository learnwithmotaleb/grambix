import 'package:get/get.dart';
import '../views/sp/controller/sp_controller.dart';

class SpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpController>(() => SpController());
  }
}
