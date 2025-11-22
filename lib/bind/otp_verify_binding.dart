import 'package:get/get.dart';
import '../views/auth/otp_verify/controller/otp_verify_controller.dart';

class OtpVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerifyController>(() => OtpVerifyController());
  }
}
