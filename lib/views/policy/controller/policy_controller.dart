import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/views/policy/model/privacy_model.dart';

class PolicyController extends GetxController {
  final RxString privacyPolicy = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPrivacyModel();
  }

  Future<PrivacyModel> getPrivacyModel() async {
    return await ApiRequest.get(
      endPoint: ApiEndPoints.privacy,
      isLoading: isLoading,
      fromJson: PrivacyModel.fromJson,
      onSuccess: (result) {
        privacyPolicy.value = result.data.description;
      },
    );
  }
}
