
part of '../screen/library_screen.dart';
class TopSelectionBar extends GetView<LibraryController> {
  const TopSelectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        Row(
          children: List.generate(
            3,
                (index) => InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                controller.selectedIndex.value = index;
              },
              child: Obx(
                    () => Container(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal:
                    Dimensions.defaultHorizontalSize * 0.5,
                    vertical: Dimensions.verticalSize * 0.1,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(
                      Dimensions.radius,
                    ),
                    color:
                    controller.selectedIndex.value == index
                        ? CustomColor.primary
                        : CustomColor.background,
                    border: Border.all(
                      color:
                      controller.selectedIndex.value ==
                          index
                          ? CustomColor.primary
                          : CustomColor.whiteColor.withAlpha(
                        99,
                      ),
                    ),
                  ),
                  margin: EdgeInsetsGeometry.only(
                    right: Dimensions.widthSize,
                  ),
                  child: TextWidget(
                    controller.textButtonList[index],
                    fontSize: Dimensions.titleSmall,
                    color:
                    controller.selectedIndex.value == index
                        ? CustomColor.background
                        : CustomColor.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        Icon(Icons.menu, color: CustomColor.primary),
      ],
    );
  }
}
