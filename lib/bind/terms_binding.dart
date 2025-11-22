import 'package:get/get.dart';
import '../views/terms/controller/terms_controller.dart';

class TermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsController>(() => TermsController());
  }
}
