import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/views/all_category/model/ebook_model.dart'
    hide Pagination;
import 'package:grambix/widgets/loading_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../core/utils/basic_import.dart';
import '../model/all_audio_book_model.dart';
import '../model/book_category_model.dart';
import '../screen/all_category_screen.dart';
import '../widget/category_widget.dart';

class AllCategoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final RxInt selectedTabIndex;
  late TabController tabController;

  RxBool allDataLoading = false.obs;
  RxBool isLoadingEbook = false.obs;
  RxBool isLoadingAudioBook = false.obs;
  RxBool isLoadingBookCategory = false.obs;
  final RxList<BookCategory> bookCategoryList = <BookCategory>[].obs;
  final RxList<Ebook> ebookList = <Ebook>[].obs;
  final RxList<AudioBook> audioBookList = <AudioBook>[].obs;

  @override
  void onInit() {
    super.onInit();
    final int tabIndex = Get.arguments ?? 0;
    selectedTabIndex = tabIndex.obs;
    tabController = TabController(
      length: tabSectionList.length,
      vsync: this,
      initialIndex: tabIndex,
    );

    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      allDataLoading.value = true;
      await Future.wait([
        getALlEbook(),
        getAllAudioBook(),

        getALlBookCategory(),
      ]);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      allDataLoading.value = false;
    }
  }

  List<String> tabSectionList = [
    Strings.all,
    'Audio Book',
    'E-book',
    'Categories',
    'Trending',
    'New Releases',
    'For You',
  ];

  void onTabSelected(int index) {
    selectedTabIndex.value = index;
    tabController.animateTo(index);
  }

  //GET ALL EBOOK
  Future<AllEbookModel> getALlEbook() async {
    return await ApiRequest.get(
      endPoint: ApiEndPoints.allEbookGet,
      isLoading: isLoadingEbook,
      fromJson: AllEbookModel.fromJson,
      onSuccess: (result) {
        ebookList.addAll(result.ebooks);
      },
    );
  }

  //GET ALL EBOOK
  Future<AllAudioBookModel> getAllAudioBook() async {
    return await ApiRequest.get(
      endPoint: ApiEndPoints.getAllAudioBook,
      isLoading: isLoadingAudioBook,
      fromJson: AllAudioBookModel.fromJson,
      onSuccess: (result) {
        audioBookList.addAll(result.data.audioBooks);
      },
    );
  }

  //GET ALL BOOK Category
  Rx<Pagination?> pagination = Rx<Pagination?>(null);

  Future<BookCategoryModel> getALlBookCategory() async {
    return await ApiRequest.get(
      endPoint: ApiEndPoints.getAllBookCategory,
      isLoading: isLoadingBookCategory,
      fromJson: BookCategoryModel.fromJson,
      onSuccess: (result) {
        bookCategoryList.addAll(result.data.bookCategories);
        pagination.value = result.data.pagination;
      },
    );
  }

  //view widget return
  buildTabBody(int index) {
    switch (index) {
      case 1:
        return AudioBooksWidget();

      case 2:
        return EbooksWidget();
      case 3:
        return CategoryWidget();

      case 4:
        return TrendingItems();
      case 5:
        return NewReleaseWidget();
      case 6:
        return RecommendedWidget();
      default:
        return SizedBox();
    }
  }
}
