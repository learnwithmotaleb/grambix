import 'package:get/get.dart';
import '../views/detail_preview/controller/detail_preview_controller.dart';

class DetailPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPreviewController>(() => DetailPreviewController());
  }
}
