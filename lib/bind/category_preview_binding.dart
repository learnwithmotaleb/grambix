import 'package:get/get.dart';
import '../views/category_preview/controller/category_preview_controller.dart';

class CategoryPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryPreviewController>(() => CategoryPreviewController());
  }
}
