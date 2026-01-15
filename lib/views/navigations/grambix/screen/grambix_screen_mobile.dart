part of 'grambix_screen.dart';

class GrambixScreenMobile extends StatefulWidget {
  const GrambixScreenMobile({super.key});

  @override
  State<GrambixScreenMobile> createState() => _GrambixScreenMobileState();
}

class _GrambixScreenMobileState extends State<GrambixScreenMobile> {
  final controller = Get.find<GrambixController>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    controller.isLoading.value = true;
    await Future.wait([
      controller.getAllFavorite(),
      controller.getUserProgress(),
    ]);
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.myGrambix, isBack: false),
      body: Obx(
            () => controller.isLoading.value
            ? LoadingWidget()
            : RefreshIndicator(
          onRefresh: _handleRefresh,
          child: controller.allFavoriteList.isEmpty &&
              controller.continueListeningList.isEmpty &&
              controller.continueReadingList.isEmpty
              ? _buildEmptyState()
              : SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.defaultHorizontalSize,
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    _buildFavoriteBooks(),
                    _buildContinueListening(),
                    _buildContinueReading(),
                    Space.height.v40,
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
    await _loadData();
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: mainCenter,
          children: [
            Space.height.v40,
            Space.height.v40,
            Space.height.v20,
            Icon(
              Icons.book_outlined,
              size: Dimensions.iconSizeLarge * 4,
              color: CustomColor.secondary,
            ),
            Space.height.v20,
            TextWidget(
              'No books available',
              fontSize: Dimensions.titleMedium,
              color: CustomColor.secondary,
              fontWeight: FontWeight.w600,
            ),
            Space.height.v10,
            TextWidget(
              'Start exploring and add books to your library',
              fontSize: Dimensions.bodyMedium,
              color: CustomColor.secondaryTextColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
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
          getTrailingIcon: (item) => item.isBook == true
              ? SvgPicture.asset(Assets.icons.music)
              : item.isEbook == true
              ? SvgPicture.asset(Assets.icons.glass)
              : SvgPicture.asset(Assets.icons.headphone),
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