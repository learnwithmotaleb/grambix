part of 'category_preview_screen.dart';

class CategoryPreviewScreenMobile extends GetView<CategoryPreviewController> {
  const CategoryPreviewScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title:controller.categoryName ?? ''),
      body: Obx(
        () => controller.isLoading.value
            ? LoadingWidget()
            : controller.categoryBookList.isEmpty
            ? EmptyDataWidget()
            : _bodyWidget(),
      ),
    );
  }

  _bodyWidget() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: Dimensions.defaultHorizontalSize,
              vertical: Dimensions.verticalSize * 0.2,
            ),
            margin: EdgeInsetsGeometry.only(
              right: Dimensions.defaultHorizontalSize,
              left: Dimensions.defaultHorizontalSize,
              bottom: Dimensions.verticalSize * 0.8,
              top: Dimensions.heightSize,
            ),
            decoration: BoxDecoration(
              color: CustomColor.secondary.withAlpha(44),
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Get.toNamed(Routes.topBooksScreen),
              child: Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.icons.grow,
                        height: Dimensions.heightSize * 4,
                      ),

                      TextWidget(
                        padding: EdgeInsetsGeometry.only(
                          left: Dimensions.widthSize,
                        ),
                        Strings.topBook,
                        color: Color(0xffFFEAB0),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: CustomColor.secondary,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RepaintBoundary(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize,
                ),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                cacheExtent: 500,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: Dimensions.widthSize * 1.25,
                  mainAxisSpacing: Dimensions.heightSize,
                  childAspectRatio: 0.51,
                ),
                itemCount: controller.categoryBookList.length,
                itemBuilder: (context, index) {
                  final data = controller.categoryBookList[index];
                  return RepaintBoundary(
                    child: GestureDetector(
                      onTap: () => Get.toNamed(
                        Routes.detailPreviewScreen,
                        arguments: data.id,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 170.h,
                            width: 130.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: CustomColor.secondary),
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius * 0.85,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius * 0.85,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: data.bookCover,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.grey.shade800,
                                  highlightColor: Colors.grey.shade700,
                                  child: Container(
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: CustomColor.secondary.withOpacity(0.1),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: CustomColor.secondary,
                                    size: 40.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Space.height.v5,
                          TextWidget(
                            padding: Dimensions.horizontalSize.edgeHorizontal * 0.1,
                            data.bookName,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.whiteColor,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.titleSmall,
                          ),
                          Padding(
                            padding: Dimensions.horizontalSize.edgeHorizontal * 0.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextWidget(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.verticalSize * 0.1,
                                    ),
                                    data.synopsis,
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontSize: Dimensions.titleSmall * 0.9,
                                    color: CustomColor.secondary,
                                  ),
                                ),
                                SvgPicture.asset(Assets.icons.headphone),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
