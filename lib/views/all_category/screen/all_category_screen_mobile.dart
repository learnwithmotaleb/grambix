part of 'all_category_screen.dart';

class AllCategoryScreenMobile extends GetView<AllCategoryController> {
  const AllCategoryScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: controller.selectedTabIndex.value,
      length: controller.tabSectionList.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: Dimensions.appBarHeight * 1.2,
          flexibleSpace: Column(children: [AppHaderWidget()]),
          bottom: TabBar(
            indicatorColor: CustomColor.primary,
            unselectedLabelColor: CustomColor.secondary,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            labelColor: CustomColor.whiteColor,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            labelStyle: TextStyle(color: Colors.cyan),
            isScrollable: true,
            onTap: (value) {
              if (value == 0) {
                Get.offAllNamed(Routes.navigation);
              }
            },
            tabs: List.generate(
              controller.tabSectionList.length,
              (index) => Tab(
                child: Text(
                  controller.tabSectionList[index],
                  style: TextStyle(
                    fontSize: Dimensions.titleSmall,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: List.generate(
              controller.tabSectionList.length,
              (index) => controller.buildTabBody(index),
            ),
          ),
        ),
      ),
    );
  }
}
