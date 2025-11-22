import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../utils/basic_import.dart';
import 'package:path_provider/path_provider.dart';

class Helpers {
  /// Validates email format and emptiness
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!GetUtils.isEmail(value)) return 'Enter a valid email';
    return null;
  }

  /// Validates password length and emptiness
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }



  /// Validates confirm password matches original password
  static String? confirmPasswordValidator(String? value, String? password) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  /// Validates name only contains alphabetic characters and spaces
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your name';
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Only alphabetic characters and spaces are allowed';
    }
    return null;
  }

  /// Validates Bangladeshi phone number format
  static String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your phone number';
    if (!RegExp(r'^(?:\+88|88)?01[1-9]\d{8}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  /// Validates date of birth with format yyyy-MM-dd
  static String? dateOfBirthValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your date of birth';
    }
    try {
      DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (e) {
      return 'Please enter a valid date in the format yyyy-MM-dd';
    }
    return null;
  }

  /// Password validations
  // RxBool hasMinChars = false.obs;
  // RxBool hasSpecialChar = false.obs;
  // RxBool hasUppercase = false.obs;
  // RxBool hasNumber = false.obs;
  //
  // // Validate password on input change
  // void validatePassword(String value) {
  //   newPassword.value = value;
  //   hasMinChars.value = value.length >= 8;
  //   hasSpecialChar.value = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
  //   hasUppercase.value = RegExp(r'[A-Z]').hasMatch(value);
  //   hasNumber.value = RegExp(r'\d').hasMatch(value);
  // }

  // void launchDialer(String phoneNumber) async {
  //   final Uri url = Uri(scheme: 'tel', path: phoneNumber);
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     Get.snackbar("Error", "Could not open dialer");
  //   }
  // }

  /// Returns the resolved [File].
  static Future<File> getProfileImageFile({
    required Rx<File?> pickedImage,
    required String? apiImageUrl,
    required RxBool isLoading,
    String defaultAssetPath = 'assets/logo/default_avatar.jpg',
    String cachedFileName = 'cached_profile.jpg',
    String defaultFileName = 'default_avatar.jpg',
  }) async {
    if (pickedImage.value != null) {
      return pickedImage.value!;
    }

    if (apiImageUrl != null && apiImageUrl.isNotEmpty) {
      try {
        isLoading.value = true;
        final response = await http.get(Uri.parse(apiImageUrl));
        if (response.statusCode == 200) {
          final tempDir = await getTemporaryDirectory();
          final cachedPath = '${tempDir.path}/$cachedFileName';
          final file = File(cachedPath);
          await file.writeAsBytes(response.bodyBytes);
          return file;
        }
      } catch (e) {
        // Optional: log or handle error
      } finally {
        isLoading.value = false;
      }
    }

    final byteData = await rootBundle.load(defaultAssetPath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$defaultFileName');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }
}
