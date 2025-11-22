import 'dart:math';
import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/res/assets.dart';
import 'package:grambix/routes/routes.dart';
import 'package:grambix/views/navigations/home/model/banner_model.dart';
import 'package:grambix/views/navigations/home/model/home_data_model.dart';

class HomeController extends GetxController {
  RxBool loadAllData = false.obs;
  RxBool isLoadingBanner = false.obs;
  RxBool isLoadingHomeData = false.obs;

  RxInt tabSelectedIndex = RxInt(0);
  final List<HomeBanner> bannerList = [];
  final List<NewRelease> trendingList = [];
  final List<NewRelease> newReleaseList = [];
  final List<NewRelease> recommendedList = [];
  final List<String> tabSectionList = [
    Strings.all,
    'Audio Book',
    'E-book',
    'Categories',
    'Trending',
    'New Releases',
    'For You',
  ];

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      loadAllData.value = true;
      await Future.wait([getHomeBanners(), getHomeData()]);
    } catch (e) {
      print(e);
    } finally {
      loadAllData.value = false;
    }
  }

  void changeTab(int index) {
    tabSelectedIndex.value = index;
    Get.toNamed(Routes.allCategoryScreen, arguments: index);
  }

  //Banner get
  Future<HomeBannerModel> getHomeBanners() async {
    return await ApiRequest.get(
      endPoint: ApiEndPoints.banner,
      isLoading: isLoadingBanner,
      fromJson: HomeBannerModel.fromJson,
      onSuccess: (result) {
        bannerList.addAll(result.data.banners);
      },
    );
  }

  //get all home data
  Future<HomeDataModel> getHomeData() async {
    return await ApiRequest.get(
      endPoint: 'home',
      isLoading: isLoadingHomeData,
      fromJson: HomeDataModel.fromJson,
      onSuccess: (result) {
        trendingList.addAll(result.data.trending);
        newReleaseList.addAll(result.data.newReleases);
        recommendedList.addAll(result.data.recommended);
        print(trendingList.length);
        print(newReleaseList.length);
        print(recommendedList.length);
      },
    );
  }
}
