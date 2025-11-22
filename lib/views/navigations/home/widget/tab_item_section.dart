part of '../screen/home_screen.dart';

class TabItemSection extends GetView<HomeController> {
  const TabItemSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: RepaintBoundary(
        child: Row(
          children: List.generate(
            controller.tabSectionList.length,
            (index) => Obx(() {
              final isSelected = controller.tabSelectedIndex.value == index;
              final tabText = controller.tabSectionList[index];
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (controller.tabSelectedIndex.value != index) {
                    HapticFeedback.selectionClick();
                    controller.changeTab(index);
                  }
                },

                child: Padding(
                  padding: EdgeInsets.only(right: Dimensions.widthSize * 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        tabText,
                        fontSize: Dimensions.titleSmall,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? CustomColor.whiteColor
                            : CustomColor.secondary,
                      ),
                      SizedBox(height: Dimensions.heightSize * 0.25),
                      isSelected
                          ? Container(
                              height: Dimensions.heightSize * 0.1,
                              width: _calculateTextWidth(
                                context,
                                tabText,
                                textStyle: TextStyle(
                                  fontSize: Dimensions.titleSmall,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              color: CustomColor.primary,
                            )
                          : SizedBox(height: Dimensions.heightSize * 0.1),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  double _calculateTextWidth(
    BuildContext context,
    String text, {
    TextStyle? textStyle,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style:
            textStyle ??
            Theme.of(context).textTheme.bodyMedium ??
            const TextStyle(),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }
}
