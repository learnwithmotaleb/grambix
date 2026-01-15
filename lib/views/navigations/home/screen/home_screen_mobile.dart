part of 'home_screen.dart';

class HomeScreenMobile extends GetView<HomeController> {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: Dimensions.appBarHeight * 1.25,
        flexibleSpace: TopBarWidget(),
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        color: CustomColor.primary,
        backgroundColor: CustomColor.background,
        onRefresh: () async {
          final hasInternet = await ApiRequest.checkInternetConnection();
          if (hasInternet) {
            controller.isLoadingHomeData();
          }
        },
        child: Obx(
          () => controller.loadAllData.value
              ? LoadingWidget()
              : FutureBuilder<bool>(
                  future: ApiRequest.checkInternetConnection(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingWidget();
                    }

                    if (snapshot.data == false) {
                      return _noInternetWidget();
                    }

                    return _bodyWidget();
                  },
                ),
        ),
      ),
    );
  }

  Widget _noInternetWidget() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: Get.height * 0.8,
        child: Center(
          child: Column(
            mainAxisAlignment: mainCenter,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: Dimensions.iconSizeLarge * 5,
                color: CustomColor.secondary,
              ),
              Space.height.v30,
              TextWidget(
                'No Internet Connection',
                fontSize: Dimensions.titleLarge * 0.9,
                color: CustomColor.whiteColor,
                fontWeight: FontWeight.bold,
              ),
              Space.height.v10,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.horizontalSize * 3,
                ),
                child: TextWidget(
                  'Please check your internet connection and try again',
                  fontSize: Dimensions.bodyMedium,
                  color: CustomColor.secondaryTextColor,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              Space.height.v30,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.horizontalSize * 3,
                ),
                child: PrimaryButtonWidget(
                  title: 'Retry',
                  onPressed: () async {
                    final hasInternet =
                        await ApiRequest.checkInternetConnection();
                    if (hasInternet) {
                      controller.isLoadingHomeData();
                    } else {
                      CustomSnackBar.error('Still no internet connection');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _bodyWidget() {
    return Padding(
      padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: Space.height.v15),
          SliverToBoxAdapter(child: HomeSliderWidget()),
          SliverToBoxAdapter(child: Space.height.v15),
          SliverToBoxAdapter(child: TabItemSection()),
          SliverToBoxAdapter(child: ItemsCardWidget()),
        ],
      ),
    );
  }
}
