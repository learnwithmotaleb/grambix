import 'package:get/get.dart';
import '../views/subcription/controller/subcription_controller.dart';

class SubcriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubcriptionsController>(() => SubcriptionsController());
  }
}
