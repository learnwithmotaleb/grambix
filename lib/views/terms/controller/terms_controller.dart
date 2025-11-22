import 'package:get/get.dart';
import 'package:grambix/views/policy/model/privacy_model.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api_request.dart';

class TermsController extends GetxController {
  final RxString terms = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTermsText();
  }

  Future<PrivacyModel> getTermsText() async {
    return await ApiRequest.get(
      endPoint: ApiEndPoints.terms,
      isLoading: isLoading,
      fromJson: PrivacyModel.fromJson,
      onSuccess: (result) {
        terms.value = result.data.description;
      },
    );
  }
}
