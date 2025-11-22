import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../model.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';

class FaqController extends GetxController {
  var faqList = <Datum>[].obs;
  var expandedIndex = (-1).obs;

  void toggleExpand(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  RxBool isLoading = false.obs;

  Future<FaqModel> fetchFaqs() async {
    return await ApiRequest.get(
      endPoint: ApiEndPoints.faqGet,
      fromJson: FaqModel.fromJson,
      onSuccess: (result) {
        // result.data -> List<Datum>
        faqList.assignAll(result.data);
      },
      isLoading: isLoading,
    );
  }
}
