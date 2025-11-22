import 'package:get/get.dart';
import '../views/all_category/controller/all_category_controller.dart';

class AllCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllCategoryController>(() => AllCategoryController());
  }
}
