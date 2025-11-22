import 'package:get/get.dart';
import '../views/offline/offline_read/controller/offline_read_controller.dart';

class OfflineReadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfflineReadController>(() => OfflineReadController());
  }
}
