import 'package:get/get.dart';
import '../views/preview/controller/preview_controller.dart';

class PreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewController>(() => PreviewController());
  }
}
