part of '../screen/library_screen.dart';

class GridCustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final String imgPath;
  final int itemCount;
  final Function()? onTap;

  const GridCustomCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.imgPath,
    required this.itemCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        cacheExtent: 500,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Dimensions.widthSize * 1.25,
          mainAxisSpacing: Dimensions.widthSize * 1.2,
          childAspectRatio: 0.69,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColor.secondary),
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius * 0.85,
                        ),
                      ),
                      child: Image.asset(
                        imgPath,
                        height: 155.h,
                        width: 158.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius,
                          ),
                          color: CustomColor.saved,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextWidget(
                          status,
                          color: CustomColor.background,
                          fontSize: Dimensions.titleSmall * 0.8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Space.height.v5,
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        title,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.whiteColor,
                        fontSize: Dimensions.titleSmall * 0.9,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Wrap(
                      spacing: Dimensions.widthSize * 0.2,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.load,
                          height: Dimensions.iconSizeDefault * 0.9,
                        ),
                        SvgPicture.asset(
                          Assets.icons.delete,
                          height: Dimensions.iconSizeDefault * 0.9,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      padding: EdgeInsets.only(left: 8.w, top: 2.h),
                      subtitle,
                      fontSize: Dimensions.titleSmall * 0.85,
                      color: CustomColor.secondary,
                    ),
                    SvgPicture.asset(Assets.icons.headphone),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
