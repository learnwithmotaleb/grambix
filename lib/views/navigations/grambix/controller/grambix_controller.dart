import 'package:get/get.dart';

import '../../../../core/api/end_point/api_end_points.dart';
import '../../../../core/api/services/api_request.dart';
import '../../../detail_preview/model/single_post_model.dart';
import '../../library/model/all_save_post_model.dart'
    show AllSavePostModel, Datum;
import '../model/grambix_model.dart' hide Data;

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
    // getAllFavorite();
    initialCalls();
  }

  Future<void> initialCalls() async {
    isLoading.value = true;
    await Future.wait([getAllFavorite(), getUserProgress()]);
    isLoading.value = false;
  }

  RxBool isFavoriteLoading = false.obs;

  Future<AllSavePostModel> getAllFavorite() async {
    return await ApiRequest.get(
      fromJson: AllSavePostModel.fromJson,
      endPoint: ApiEndPoints.bookMarkData,
      isLoading: isFavoriteLoading,
      onSuccess: (result) {
        allFavoriteList.clear();
        allFavoriteList.assignAll(result.data);
        // getUserProgress();
      },
    );
  }

  RxBool isContinueLoading = false.obs;

  Future<GrambixModel> getUserProgress() async {
    return await ApiRequest.get(
      fromJson: GrambixModel.fromJson,
      endPoint: ApiEndPoints.userProgress,
      isLoading: isContinueLoading,
      onSuccess: (result) {
        // ✅ Proper logging
        print('✅ getUserProgress SUCCESS');
        print('📖 Continue Reading: ${result.data?.continueReading?.length} items');
        print('🎵 Continue Listening: ${result.data?.continueListening?.length} items');

        final reading = result.data?.continueReading;
        final listening = result.data?.continueListening;

        continueReadingList.assignAll(reading ?? []);
        continueListeningList.assignAll(listening ?? []);

        // ✅ Debug individual items
        if (reading?.isNotEmpty == true) {
          print('\n📚 Continue Reading Items:');
          for (var item in reading !) {
            print('  - Book ID: ${item.contentId}');
            print('    Current Page: ${item.currentPage! + 1}/${item.totalPages}');
            print('    Progress: ${item.readingProgress}%');
          }
        }

        if (listening!.isNotEmpty) {
          print('\n🎧 Continue Listening Items:');
          for (var item in listening) {
            print('  - Audio ID: ${item.contentId}');
            print('    Current Time: ${item.currentTime}s/${item.totalDuration}s');
            print('    Progress: ${item.listeningProgress}%');
          }
        }
      },
    );
  }

  RxBool isLoadingBookDetails = false.obs;

// ✅ contentId দিয়ে full book details আনবে
  Future<Data?> getBookDetailsById(String contentId) async {
    try {
      final result = await ApiRequest.get(
        fromJson: SinglePostModel.fromJson,
        endPoint: ApiEndPoints.singlePost,
        queryParams: {'id': contentId}, // ✅ Query parameter hisebe pass koro
        isLoading: isLoadingBookDetails,
      );

      return result.data;
    } catch (e) {
      print('❌ Error fetching book details: $e');
      Get.snackbar(
        'Error',
        'Failed to load audio details',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

}
