import 'dart:io';

import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/views/navigations/profile/model/user_profile_model.dart';
import 'package:grambix/widgets/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getProfileInfo();
  }

  //GET USER PROFILE INFO
  RxBool isLoading = false.obs;
  Rx<UserProfileModel?> profileInfo = Rx<UserProfileModel?>(null);

  Future<UserProfileModel> getProfileInfo() async {
    return await ApiRequest.get(
      endPoint: ApiEndPoints.profile,
      isLoading: isLoading,
      fromJson: UserProfileModel.fromJson,
      onSuccess: (result){
        profileInfo.value = result;
        print('**************************************************************');
        print('**************************************************************');

      }
    );
  }
}
