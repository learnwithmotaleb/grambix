part of '../screen/detail_preview_screen.dart';

class SelectButton extends GetView<DetailPreviewController> {
  const SelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(
        2,
        (index) => InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            controller.isEbook.value = index;
          },
          child: Obx(
            () => Container(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: Dimensions.defaultHorizontalSize * 0.5,
                vertical: Dimensions.verticalSize * 0.1,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(Dimensions.radius),
                color: controller.isEbook.value == index
                    ? CustomColor.primary
                    : CustomColor.background,
                border: Border.all(
                  color: controller.isEbook.value == index
                      ? CustomColor.primary
                      : CustomColor.whiteColor.withAlpha(99),
                ),
              ),
              margin: EdgeInsetsGeometry.only(right: Dimensions.widthSize),
              child: TextWidget(
                controller.textButtonList[index],
                fontSize: Dimensions.titleSmall,
                color: controller.isEbook.value == index
                    ? CustomColor.background
                    : CustomColor.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
