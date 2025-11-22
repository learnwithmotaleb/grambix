part of '../screen/find_screen.dart';

class SerchItems extends GetView<FindController> {
  const SerchItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final results = controller.searchResults;

      if (results.isEmpty) {
        return const EmptyDataWidget();
      }

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalSize,
          vertical: Dimensions.verticalSize * 0.5,
        ),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: results.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // OR use dynamic count based on width if needed
            crossAxisSpacing: Dimensions.widthSize * 1.25,
            mainAxisSpacing: Dimensions.widthSize * 1.2,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final item = results[index];
            return RepaintBoundary(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.secondary),
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius * 0.85,
                      ),
                    ),
                    child: Image.asset(
                      item.imageUrl,
                      height: 155.h,
                      width: 158.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Space.height.v5,
                  TextWidget(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    item.title,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.whiteColor,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          padding: EdgeInsets.only(top: 2.h),
                          item.subtitle,
                          fontSize: Dimensions.titleSmall,
                          color: CustomColor.whiteColor,
                        ),
                        SvgPicture.asset(Assets.icons.headphone),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
