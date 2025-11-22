import 'package:get/get.dart';

import '../views/offline/offline_preview/controller/offline_preview_controller.dart';

class OfflinePreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfflinePreviewController>(() => OfflinePreviewController());
  }
}
