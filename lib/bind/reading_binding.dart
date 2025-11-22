import 'package:get/get.dart';
import '../views/reading/controller/reading_controller.dart';

class ReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadingController>(() => ReadingController());
  }
}
