import 'package:get/get.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/core/api/services/auth_services.dart';

import '../../../core/utils/basic_import.dart';

class PassChangeController extends GetxController {
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxBool isLoading = false.obs;

  changePasswordProcess() async {
    return await AuthServices.changePassword(
      isLoading: isLoading,
      currentPassword: passwordController.text,
      newPassword: newPasswordController.text,
      confirmPassword: confirmPasswordController.text,
    );
  }
}
