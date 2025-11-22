part of 'grambix_screen.dart';

class GrambixScreenMobile extends GetView<GrambixController> {
  const GrambixScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getAllFavorite();
    return Scaffold(
      appBar: CommonAppBar(title: Strings.myGrambix, isBack: false),
      body: Obx(
        () => controller.isLoading.value
            ? LoadingWidget()
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultHorizontalSize,
                  ),
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
                        Space.height.v40,
                        Space.height.v40,
                        Space.height.v40,
                        Space.height.v40,
                        Space.height.v40,
                        Space.height.v40,

                        EmptyDataWidget(),
                      ],

                      if (controller.continueListeningList.isNotEmpty) ...[
                        // TextWidget(
                        //   padding: EdgeInsets.only(
                        //     bottom: Dimensions.verticalSize * 0.4,
                        //     top: Dimensions.verticalSize * 0.5,
                        //   ),
                        //   Strings.continueListening,
                        //   color: CustomColor.whiteColor,
                        //   fontWeight: FontWeight.w600,
                        //   fontSize: Dimensions.titleMedium * 1.1,
                        // ),
                        // CustomItemsCardWidget(
                        //   items: controller.continueListeningList,
                        //   getImagePath: (item) => 'item.bookCover',
                        //   getTitle: (item) => 'item.bookName',
                        //   getSubtitle: (item) => 'item.synopsis',
                        //   argument: (item) => item.id,
                        //   // getTrailingIcon: (item) => item.isEbook == true
                        //   //     ? SvgPicture.asset(Assets.icons.music)
                        //   //     : item.isEbook == false
                        //   //     ? SvgPicture.asset(Assets.icons.headphone)
                        //   //     : SvgPicture.asset(Assets.icons.glass),
                        // ),
                      ],
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
