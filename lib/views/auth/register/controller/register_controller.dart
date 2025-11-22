import 'package:grambix/core/api/services/auth_services.dart';

import '../../../../core/utils/basic_import.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  RxString selectedCountry = "Select Country".obs;

  RxBool isLoading = false.obs;

  registerProcess() async {
    return await AuthServices.registerService(
      isLoading: isLoading,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      country: selectedCountry.value,
    );
  }
}
