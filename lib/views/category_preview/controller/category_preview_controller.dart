import 'package:get/get.dart';
import 'package:grambix/views/category_preview/model/category_preview_model.dart';

import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api_request.dart';

class CategoryPreviewController extends GetxController {
  late final String selectedCategoryId;

  @override
  void onInit() {
    super.onInit();
    selectedCategoryId = Get.arguments;
    print(selectedCategoryId);
    getALlCategoryBook();
  }

  final List<BookData> categoryBookList = [];
  RxBool isLoading = false.obs;

  Future<CategoryPreviewModel> getALlCategoryBook() async {
    return await ApiRequest.get(
      queryParams: {'categoryId': selectedCategoryId},
      endPoint: ApiEndPoints.categoryPreview,
      isLoading: isLoading,
      fromJson: CategoryPreviewModel.fromJson,
      onSuccess: (result) {
        print(
          '//////////////////////////////////////////////////////////////////////',
        );
        categoryBookList.addAll(result.data.books);
      },
    );
  }
}
