import 'package:grambix/core/api/services/auth_services.dart';

import '../../../../core/utils/basic_import.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  RxBool isLoading = false.obs;

  forgetPasswordProcess() async {
    return await AuthServices.forgetPasswordService(
      isLoading: isLoading,
      email: emailController.text,
    );
  }
}
