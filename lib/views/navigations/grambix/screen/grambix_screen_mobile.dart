part of 'grambix_screen.dart';

class GrambixScreenMobile extends GetView<GrambixController> {
  const GrambixScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getAllFavorite();
    controller.getUserProgress();

    return Scaffold(
      appBar: CommonAppBar(title: Strings.myGrambix, isBack: false),
      body: Obx(
            () => controller.isLoading.value
            ? LoadingWidget()
            : RefreshIndicator(
          onRefresh: _handleRefresh,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.defaultHorizontalSize,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    _buildFavoriteBooks(),
                    _buildContinueListening(),
                    _buildContinueReading(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    controller.continueReadingList.clear();
    controller.continueListeningList.clear();
    controller.allFavoriteList.clear();
    await controller.getAllFavorite();
    await controller.getUserProgress();
  }

  Widget _buildFavoriteBooks() {
    if (controller.allFavoriteList.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: crossStart,
      children: [
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
          getTrailingIcon: (item) => _getBookTypeIcon(item),
        ),
      ],
    );
  }

  Widget _buildContinueListening() {
    if (controller.continueListeningList.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: crossStart,
      children: [
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
          getImagePath: (item) => item.contentId?.bookCover ?? '',
          getTitle: (item) => item.contentId?.bookName ?? '',
          getSubtitle: (item) => item.contentId?.synopsis ?? '',
          argument: (item) => item.id ?? '',
          onTap: (item) => _handleContinueListening(item),
        ),
      ],
    );
  }

  Widget _buildContinueReading() {
    if (controller.continueReadingList.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: crossStart,
      children: [
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
          getImagePath: (item) => item.contentId?.bookCover ?? '',
          getTitle: (item) => item.contentId?.bookName ?? '',
          getSubtitle: (item) => item.contentId?.synopsis ?? '',
          argument: (item) => item.id ?? '',
          onTap: (item) => _handleContinueReading(item),
        ),
      ],
    );
  }

  Widget _getBookTypeIcon(item) {
    if (item.isEbook == true) {
      return SvgPicture.asset(Assets.icons.music);
    } else if (item.isEbook == false) {
      return SvgPicture.asset(Assets.icons.headphone);
    } else {
      return SvgPicture.asset(Assets.icons.glass);
    }
  }

  Future<void> _handleContinueListening(item) async {
    try {
      final bookData = await controller.getBookDetailsById(
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
        CustomSnackBar.error('Failed to load audio details');
      }
    } catch (e) {
      print('❌ Error: $e');
      CustomSnackBar.error('Something went wrong');
    }
  }

  Future<void> _handleContinueReading(item) async {
    try {
      final bookData = await controller.getBookDetailsById(
        item.contentId?.id ?? '',
      );

      if (bookData != null) {
        if (bookData.pdfFile.isNotEmpty) {
          Get.toNamed(
            Routes.readingScreen,
            arguments: {
              'item': bookData,
              'currentPage': item.currentPage,
            },
          );
        } else {
          CustomSnackBar.error('This book does not have a PDF file');
        }
      } else {
        CustomSnackBar.error('Failed to load book details');
      }
    } catch (e) {
      print('❌ Error in Continue Reading: $e');
      CustomSnackBar.error('Something went wrong');
    }
  }
}