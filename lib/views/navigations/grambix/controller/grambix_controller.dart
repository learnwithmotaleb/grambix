import 'package:get/get.dart';

import '../../../../core/api/end_point/api_end_points.dart';
import '../../../../core/api/services/api_request.dart';
import '../../library/model/all_save_post_model.dart'
    show AllSavePostModel, Datum;
import '../model/grambix_model.dart';

class GrambixController extends GetxController {
  final RxInt pageNumber = 2.obs;
  final RxInt totalPages = 10.obs;

  // Make it reactive
  RxList<Datum> allFavoriteList = <Datum>[].obs;

  RxList<ContinueIng> continueReadingList = <ContinueIng>[].obs;
  RxList<ContinueIng> continueListeningList = <ContinueIng>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllFavorite();
  }

  Future<void> initialCalls() async {
    isLoading.value = true;
    await Future.wait([getAllFavorite(), getUserProgress()]);

    isLoading.value = false;
  }

  Future<AllSavePostModel> getAllFavorite() async {
    return await ApiRequest.get(
      fromJson: AllSavePostModel.fromJson,
      endPoint: ApiEndPoints.bookMarkData,
      isLoading: isLoading,
      onSuccess: (result) {
        allFavoriteList.clear();
        allFavoriteList.assignAll(result.data);
        // getUserProgress();
      },
    );
  }

  Future<GrambixModel> getUserProgress() async {
    return await ApiRequest.get(
      fromJson: GrambixModel.fromJson,
      endPoint: ApiEndPoints.userProgress,
      isLoading: isLoading,
      onSuccess: (result) {
        print("Continue Reading: ${result.data.continueReading}");
        print("Continue Listening: ${result.data.continueListening}");
        continueReadingList.assignAll(result.data.continueReading);
        continueListeningList.assignAll(result.data.continueListening);
      },
    );
  }
}
