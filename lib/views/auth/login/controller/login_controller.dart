import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grambix/core/api/services/auth_services.dart';
import 'package:grambix/views/auth/login/model/login_model.dart';

import '../../../../core/helpers/helpers.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxString email = ''.obs;
  RxString emailError = ''.obs;

  void onEmailChanged(String value) {
    email.value = value;
    emailError.value = Helpers.emailValidator(value) ?? '';
  }

  RxBool isLoading = false.obs;

  Future<LoginModel> loginProcess() async {
    return await AuthServices.loginService(
      isLoading: isLoading,
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
