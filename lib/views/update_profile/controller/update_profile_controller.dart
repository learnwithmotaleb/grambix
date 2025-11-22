import 'dart:io';

import 'package:get/get.dart';
import 'package:grambix/views/navigations/profile/controller/profile_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../navigations/profile/model/user_profile_model.dart';
import '../update_profile_model.dart';

class UpdateProfileController extends GetxController {
  final profileController = Get.find<ProfileController>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final _imagePicker = ImagePicker();
  RxBool isLoading = false.obs;
  final Rx<File?> selectedImg = Rx(null);

  Future<void> pickImg() async {
    final pickedImg = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImg != null) {
      selectedImg.value = File(pickedImg.path);
    } else {
      CustomSnackBar.error('Image not selected');
    }
  }

  /// Handle update profile process
  Future<UpdateProfileModel?> updateProfile() async {
    final Map<String, File?> fileMap = {};
    if (selectedImg.value != null) {
      fileMap['profilePicture'] = selectedImg.value;
    }
    return await ApiRequest.multiMultipartRequest(
      endPoint: ApiEndPoints.updateProfile,
      reqType: "PUT",
      isLoading: isLoading,
      body: {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'phone': phoneController.text.trim(),
      },
      files: fileMap,
      fromJson: UpdateProfileModel.fromJson,
      showSuccessSnackBar: true,
      onSuccess: (result) {
        Get.offAllNamed(Routes.navigation);
      },
    );
  }
}
