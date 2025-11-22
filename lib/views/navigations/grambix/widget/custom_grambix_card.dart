part of '../screen/grambix_screen.dart';

class CustomGrambixCard extends GetView<GrambixController> {
  final String title;
  final String subtitle;
  final String imagePath;
  final String heading;
  final String iconPath;
  final VoidCallback? onTap;
  final int itemCount;

  const CustomGrambixCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.iconPath,
    this.onTap,
    required this.heading,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget(
          padding: Dimensions.verticalSize.edgeBottom * 0.4,
          heading,
          color: CustomColor.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.titleMedium * 1.1,
        ),
        RepaintBoundary(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.29,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              cacheExtent: 500,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:
                      onTap ?? () => Get.toNamed(Routes.detailPreviewScreen),
                  child: Container(
                    margin: EdgeInsets.only(right: Dimensions.widthSize * 1.2),
                    width: 135.w,
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
                          child: Image.network(
                            imagePath,
                            height: 135.h,
                            width: 135.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Space.height.v5,
                        Row(
                          children: [
                            Expanded(
                              child: TextWidget(
                                title,
                                padding:
                                    Dimensions.horizontalSize.edgeHorizontal *
                                    0.1,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.whiteColor,
                                fontSize: Dimensions.titleSmall,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SvgPicture.asset(iconPath),
                          ],
                        ),
                        Padding(
                          padding:
                              Dimensions.horizontalSize.edgeHorizontal * 0.1,
                          child: TextWidget(
                            subtitle,
                            maxLines: 1,
                            fontSize: Dimensions.titleSmall * 0.9,
                            color: CustomColor.secondary,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 2.0,
                                  activeTrackColor: CustomColor.blueColor,
                                  inactiveTrackColor: CustomColor.secondary,
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 0,
                                  ),
                                  thumbColor: CustomColor.whiteColor,
                                ),
                                child: Slider(
                                  padding: EdgeInsetsGeometry.zero,
                                  min: 0,
                                  max: controller.totalPages.value.toDouble(),
                                  value: controller.pageNumber.value
                                      .toDouble()
                                      .clamp(
                                        1,
                                        controller.totalPages.value.toDouble(),
                                      ),
                                  onChanged: (value) {},
                                ),
                              ),
                            ),
                            Space.width.v5,
                            TextWidget(
                              '20%',
                              color: CustomColor.secondary,
                              fontSize: Dimensions.titleSmall * 0.8,
                            ),
                          ],
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
    );
  }
}
