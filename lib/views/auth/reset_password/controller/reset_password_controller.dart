import 'package:grambix/core/api/services/auth_services.dart';
import 'package:grambix/views/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:grambix/views/auth/otp_verify/controller/otp_verify_controller.dart';
import 'package:grambix/views/auth/register/controller/register_controller.dart';
import 'package:grambix/views/otp/controller/otp_controller.dart';

import '../../../../core/utils/basic_import.dart';

class ResetPasswordController extends GetxController {
  final passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  resetPasswordProcess() async {
    return await AuthServices.resetPasswordService(
      isLoading: isLoading,
      email: Get.find<ForgotPasswordController>().emailController.text,
      code: Get.find<OtpController>().otpController.text,
      newPassword: passwordController.text,
    );
  }
}
