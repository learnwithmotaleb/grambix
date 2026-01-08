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
          await ApiRequest.checkInternetConnection();
          controller.isLoadingHomeData();
        },
        child: Obx(
          () => controller.loadAllData.value ? LoadingWidget() : _bodyWidget(),
        ),
      ),
    );
  }

  Padding _bodyWidget() {
    return Padding(
      padding: Dimensions.defaultHorizontalSize.edgeHorizontal,

      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),

        slivers: [
          // SliverToBoxAdapter(child: SearchBarWidget()),
          SliverToBoxAdapter(child: Space.height.v15),
          SliverToBoxAdapter(child: HomeSliderWidget()),
          SliverToBoxAdapter(child: Space.height.v15),
          SliverToBoxAdapter(child: TabItemSection()),

          SliverToBoxAdapter(child: ItemsCardWidget()),

          //Home page test for commit
        ],
      ),
    );
  }
}
