import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grambix/core/api/services/auth_services.dart';

import '../../../../core/helpers/helpers.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxString email = ''.obs;
  RxString emailError = ''.obs;

  @override
  void onInit() {
    emailController.text = 's5ra@yopmail.com';
    passwordController.text = '111111';
    super.onInit();

  }

  void onEmailChanged(String value) {
    email.value = value;
    emailError.value = Helpers.emailValidator(value) ?? '';
  }

  RxBool isLoading = false.obs;

  loginProcess() async {
    return await AuthServices.loginService(
      isLoading: isLoading,
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
