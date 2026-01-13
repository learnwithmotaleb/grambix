part of 'grambix_screen.dart';

class GrambixScreenMobile extends GetView<GrambixController> {
  const GrambixScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getAllFavorite();
     controller.getAllFavorite();
     controller.getUserProgress();
    return Scaffold(
      appBar: CommonAppBar(title: Strings.myGrambix, isBack: false),
      body: Obx(
        () => controller.isLoading.value
            ? LoadingWidget()
            : RefreshIndicator(
          onRefresh: () async {
                await controller.getAllFavorite();
                await controller.getUserProgress();

          },
              child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultHorizontalSize,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          if (controller.allFavoriteList.isNotEmpty) ...[
                            TextWidget(
                              padding: EdgeInsets.only(
                                bottom: Dimensions.verticalSize * 0.4,
                                top: Dimensions.verticalSize * 0.5,
                              ),
                              "Favorite Books",
                              color: CustomColor.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.titleMedium * 1.1,
                            ),
                            CustomItemsCardWidget(
                              items: controller.allFavoriteList,
                              getImagePath: (item) => item.bookCover,
                              getTitle: (item) => item.bookName,
                              getSubtitle: (item) => item.synopsis,
                              argument: (item) => item.id,
                              getTrailingIcon: (item) => item.isEbook == true
                                  ? SvgPicture.asset(Assets.icons.music)
                                  : item.isEbook == false
                                  ? SvgPicture.asset(Assets.icons.headphone)
                                  : SvgPicture.asset(Assets.icons.glass),
                            ),
                          ] else ...[
                            EmptyDataWidget(),
                          ],

                          if (controller.continueListeningList.isNotEmpty) ...[
                            TextWidget(
                              padding: EdgeInsets.only(
                                bottom: Dimensions.verticalSize * 0.4,
                                top: Dimensions.verticalSize * 0.5,
                              ),
                              Strings.continueListening,
                              color: CustomColor.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.titleMedium * 1.1,
                            ),
                            CustomItemsCardWidget(
                              items: controller.continueListeningList,
                              getImagePath: (item) =>
                                  item.contentId?.bookCover ?? '',
                              getTitle: (item) => item.contentId?.bookName ?? '',
                              getSubtitle: (item) =>
                                  item.contentId?.synopsis ?? '',
                              argument: (item) => item.id ?? '',

                              onTap: (item) async {
                                try {

                                  final GrambixController grambixController =
                                      Get.find<GrambixController>();
                                  final bookData = await grambixController
                                      .getBookDetailsById(
                                        item.contentId?.id ?? '',
                                      );

                                  if (bookData != null) {
                                    Get.toNamed(
                                      Routes.playerScreen,
                                      arguments: {
                                        'item': bookData,
                                        'currentTime': item.currentTime,
                                      },
                                    );
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'Failed to load audio details',
                                    );
                                  }
                                } catch (e) {
                                  print('❌ Error: $e');
                                  Get.snackbar('Error', 'Something went wrong');
                                }
                              },
                            ),
                          ],

                          if (controller.continueReadingList.isNotEmpty) ...[
                            TextWidget(
                              padding: EdgeInsets.only(
                                bottom: Dimensions.verticalSize * 0.4,
                                top: Dimensions.verticalSize * 0.5,
                              ),
                              Strings.continueReading,
                              color: CustomColor.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.titleMedium * 1.1,
                            ),
                            CustomItemsCardWidget(
                              items: controller.continueReadingList,
                              getImagePath: (item) =>
                                  item.contentId?.bookCover ?? '',
                              getTitle: (item) => item.contentId?.bookName ?? '',
                              getSubtitle: (item) =>
                                  item.contentId?.synopsis ?? '',
                              argument: (item) => item.id ?? '',
                              onTap: (item) async {
                                try {
                                  // ✅ No dialog loading
                                  print('🔍 Fetching book for contentId: ${item.contentId}');

                                  final GrambixController grambixController = Get.find<GrambixController>();

                                  // ✅ contentId দিয়ে API call
                                  final  bookData = await grambixController.getBookDetailsById(item.contentId?.id ?? '');

                                  if (bookData != null) {
                                    print('✅ Book found: ${bookData.bookName}');

                                    // ✅ Check if it's PDF or not
                                    if (bookData.pdfFile.isNotEmpty) {
                                      // ✅ Navigate to reading screen with saved page
                                      Get.toNamed(
                                        Routes.readingScreen,
                                        arguments: {
                                          'item': bookData,
                                          'currentPage': item.currentPage, // ✅ Saved page (0-indexed)
                                        },
                                      );
                                    } else {
                                      Get.snackbar('Error', 'This book does not have a PDF file');
                                    }
                                  } else {
                                    print('❌ Book not found for contentId: ${item.contentId}');
                                    Get.snackbar('Error', 'Failed to load book details');
                                  }

                                } catch (e) {
                                  print('❌ Error in Continue Reading: $e');
                                  Get.snackbar('Error', 'Something went wrong: $e');
                                }
                              },
                              // getTrailingIcon: (item) => item.contentId == true
                              //     ? SvgPicture.asset(Assets.icons.music)
                              //     : item.isEbook == false
                              //     ? SvgPicture.asset(Assets.icons.headphone)
                              //     : SvgPicture.asset(Assets.icons.glass),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
            ),
      ),
    );
  }
}
