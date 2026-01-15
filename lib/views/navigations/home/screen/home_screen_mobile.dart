part of 'home_screen.dart';

class HomeScreenMobile extends GetView<HomeController> {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() => _buildBody()),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: Dimensions.appBarHeight * 1.25,
      flexibleSpace: TopBarWidget(),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBody() {
    if (controller.loadAllData.value) {
      return LoadingWidget();
    }

    return FutureBuilder<bool>(
      future: ApiRequest.checkInternetConnection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWidget();
        }

        if (snapshot.data == false) {
          return _buildNoInternetState();
        }

        return _buildHomeContent();
      },
    );
  }

  Widget _buildHomeContent() {
    return RefreshIndicator(
      color: CustomColor.primary,
      backgroundColor: CustomColor.background,
      onRefresh: _handleRefresh,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverPadding(
            padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Space.height.v15,
                HomeSliderWidget(),
                Space.height.v15,
                TabItemSection(),
                ItemsCardWidget(),
                Space.height.v40,
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoInternetState() {
    return RefreshIndicator(
      color: CustomColor.primary,
      backgroundColor: CustomColor.background,
      onRefresh: _handleRefresh,
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
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
                      onPressed: _handleRetry,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    final hasInternet = await ApiRequest.checkInternetConnection();
    if (hasInternet) {
      await controller.isLoadingHomeData();
    }
  }

  Future<void> _handleRetry() async {
    final hasInternet = await ApiRequest.checkInternetConnection();
    if (hasInternet) {
      await controller.isLoadingHomeData();
    } else {
      CustomSnackBar.error('Still no internet connection');
    }
  }
}