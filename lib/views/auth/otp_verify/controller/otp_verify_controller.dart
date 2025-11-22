import 'package:grambix/core/api/model/basic_success_model.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/core/api/services/auth_services.dart';
import 'package:grambix/views/auth/register/controller/register_controller.dart';

import '../../../../core/utils/basic_import.dart';

class OtpVerifyController extends GetxController {
  final otpController = TextEditingController();

  RxBool isLoading = false.obs;

  emailVerify() async {
    return await AuthServices.emailVerifyService(
      isLoading: isLoading,
      email: Get.find<RegisterController>().emailController.text,
      code: otpController.text,
    );
  }
}
