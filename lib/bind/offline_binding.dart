import 'package:get/get.dart';
import '../views/offline/controller/offline_controller.dart';

class OfflineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfflineController>(() => OfflineController());
  }
}
