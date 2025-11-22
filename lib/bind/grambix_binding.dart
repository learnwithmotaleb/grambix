import 'package:get/get.dart';

import '../views/navigations/grambix/controller/grambix_controller.dart';

class GrambixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GrambixController>(() => GrambixController());
  }
}
