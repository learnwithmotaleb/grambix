part of '../screen/detail_preview_screen.dart';

class TopTextHeading extends GetView<DetailPreviewController> {
  const TopTextHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.defaultHorizontalSize,
        right: Dimensions.defaultHorizontalSize,
        top: MediaQuery.of(context).size.height * 0.1,
        bottom: Dimensions.verticalSize * 1.5,
      ),
      child: Column(
        children: [
          TextWidget(
            controller.singleData.first.bookName,
            fontSize: Dimensions.titleLarge * 0.9,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
            color: Colors.white,
          ),
          TextWidget(
            padding: EdgeInsetsGeometry.only(
              top: Dimensions.verticalSize * 0.2,
            ),
            controller.singleData.first.synopsis,
            maxLines: 1,
            textAlign: TextAlign.center,
            color: CustomColor.secondary,
          ),
          Space.height.v5,

          Container(
            decoration: BoxDecoration(
              color: CustomColor.secondary.withAlpha(88),
              borderRadius: BorderRadiusGeometry.circular(
                Dimensions.radius * 0.5,
              ),
              border: Border.all(
                color: CustomColor.whiteColor.withAlpha(88),
                width: 1.2,
              ),
            ),

            padding: EdgeInsetsGeometry.symmetric(
              horizontal: Dimensions.defaultHorizontalSize * 1.8,
              vertical: Dimensions.verticalSize * 0.15,
            ),
            child: TextWidget(
              Strings.fiction,
              color: CustomColor.secondary,
              fontSize: Dimensions.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
