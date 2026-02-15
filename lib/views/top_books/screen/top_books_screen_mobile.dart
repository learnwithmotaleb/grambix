part of 'top_books_screen.dart';

class TopBooksScreenMobile extends GetView<TopBooksController> {
  const TopBooksScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.topTenBook),
      body: SafeArea(
        child: ListView.builder(
          itemCount: min(Get.find<HomeController>().trendingList.length, 10),
          cacheExtent: 500,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: Dimensions.defaultHorizontalSize,
          ),
          itemBuilder: (context, index) {
            final data = Get.find<HomeController>().trendingList[index];
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.verticalSize * 0.25,
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () =>
                    Get.toNamed(Routes.detailPreviewScreen, arguments: data.id),
                child: Row(
                  crossAxisAlignment: crossStart,
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Container(
                      height: 175.h,
                      width: 130.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColor.secondary),
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius * 0.85,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(
                          Dimensions.radius * 0.85,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: data.bookCover,
                          height: 150.h,
                          width: 140.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Space.width.v10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          TextWidget(
                            data.bookName,
                            color: CustomColor.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                          TextWidget(
                            data.synopsis,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            color: CustomColor.whiteColor,
                            fontSize: Dimensions.titleSmall,
                          ),
                          Space.height.v5,

                          SvgPicture.asset(
                            Assets.icons.headphone,
                            color: CustomColor.whiteColor,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: CustomColor.secondary.withAlpha(88),
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius * 0.2,
                        ),
                      ),
                      child: Text(
                        '  #${index + 1}  ',
                        style: TextStyle(color: CustomColor.whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
