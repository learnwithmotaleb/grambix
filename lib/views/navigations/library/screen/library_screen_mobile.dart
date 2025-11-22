part of 'library_screen.dart';

class LibraryScreenMobile extends StatelessWidget {
  const LibraryScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LibraryController(), permanent: true);
    controller.initStorage();
    return Scaffold(
      appBar: CommonAppBar(title: Strings.library, isBack: false),
      body: RefreshIndicator(
        color: CustomColor.primary,
        backgroundColor: CustomColor.background,
        onRefresh: () async => await controller.loadDownloads(),
        child: Obx(() {
          if (controller.downloadedItems.isEmpty) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.defaultHorizontalSize,
                vertical: Dimensions.verticalSize * 0.2,
              ),
              children: [
                Space.height.v40,
                Space.height.v40,
                EmtyLibraryWidget(),
              ],
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.defaultHorizontalSize,
            ),
            child: Column(
              crossAxisAlignment: crossStart,
              children: [Expanded(child: LibrrayCard(),),],
            ),
          );
        }),
      ),
    );
  }
}
