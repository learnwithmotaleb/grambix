import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/api/model/basic_success_model.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/core/utils/app_storage.dart';
import 'package:grambix/views/auth/login/model/login_model.dart';
import '../../../routes/routes.dart';

class AuthServices {
  /// =============================================== ✅ Login  ================================================== ///
  ///
  static Future<LoginModel> loginService({
    required RxBool isLoading,
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> inputBody = {'email': email, 'password': password};
    return await ApiRequest.post(
      fromJson: LoginModel.fromJson,
      endPoint: ApiEndPoints.login,
      isLoading: isLoading,
      body: inputBody,
      onSuccess: (result) {
        AppStorage.save(
          token: result.token,
          temporaryToken: result.refreshToken,
          isLoggedIn: true,
        );
        Get.offAllNamed(Routes.navigation);
      },
    );
  }

  /// =============================================== ✅ Register  ================================================== ///

  static Future<BasicSuccessModel> registerService({
    required RxBool isLoading,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String country,
  }) async {
    Map<String, dynamic> inputBody = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'country': country,
    };
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.register,
      isLoading: isLoading,
      body: inputBody,
      showSuccessSnackBar: true,
      onSuccess: (result) => Get.toNamed(Routes.otpVerifyScreen),
    );
  }

  /// =============================================== ✅ Email Verify  ================================================== ///

  static Future<BasicSuccessModel> emailVerifyService({
    required RxBool isLoading,
    required String email,
    required String code,
  }) async {
    Map<String, dynamic> inputBody = {'email': email, 'code': code};
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.verifyEmail,
      isLoading: isLoading,
      body: inputBody,
      onSuccess: (result) => Get.offAllNamed(Routes.loginScreen),
    );
  }

  /// =============================================== ✅ Resend Verification ================================================== ///

  static Future<BasicSuccessModel> resentVerificationService({
    required RxBool isLoading,
    required String email,
  }) async {
    Map<String, dynamic> inputBody = {'email': email};
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.resendVerification,
      isLoading: isLoading,
      body: inputBody,
    );
  }

  /// =============================================== ✅ Reset Password ================================================== ///

  static Future<BasicSuccessModel> resetPasswordService({
    required RxBool isLoading,
    required String email,
    required String code,
    required String newPassword,

    required,
  }) async {
    Map<String, dynamic> inputBody = {
      'email': email,
      'code': code,
      'newPassword': newPassword,
    };
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.resetPassword,
      isLoading: isLoading,
      body: inputBody,
      showSuccessSnackBar: true,
      onSuccess: (result) {
        Get.offAllNamed(Routes.loginScreen);
      },
    );
  }

  /// =============================================== ✅ Forget Password ================================================== ///

  static Future<BasicSuccessModel> forgetPasswordService({
    required RxBool isLoading,
    required String email,
    required,
  }) async {
    Map<String, dynamic> inputBody = {'email': email};
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.forgotPassword,
      isLoading: isLoading,
      body: inputBody,
      showSuccessSnackBar: true,
      onSuccess: (result) => Get.toNamed(Routes.otpScreen),
    );
  }

  /// =============================================== ✅ Change Password ================================================== ///

  static Future<BasicSuccessModel> changePassword({
    required RxBool isLoading,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required,
  }) async {
    Map<String, dynamic> inputBody = {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.changePassword,
      isLoading: isLoading,
      body: inputBody,
      showSuccessSnackBar: true,
      onSuccess: (result) => Get.toNamed(Routes.navigation),
    );
  }
}
