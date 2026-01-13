part of '../screen/reading_screen.dart';

class BottomWidget extends GetView<ReadingController> {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.defaultHorizontalSize * 2,
        vertical: Dimensions.verticalSize * 0.2,
      ),
      color: controller.isDark.value ? Colors.black : Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Page info
          Obx(
                () => TextWidget(
              padding: EdgeInsets.only(bottom: Dimensions.heightSize * 0.5),
              "Page ${controller.currentPage.value + 1} of ${controller.totalPages.value}",
              color: controller.isDark.value ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Slider for page navigation
          Obx(
                () => Slider(
                  padding: EdgeInsetsGeometry.zero,
                  min: 0,
                  max: (controller.totalPages.value > 0
                      ? controller.totalPages.value.toDouble() - 1
                      : 0),
                  value: controller.currentPage.value.toDouble().clamp(
                    0,
                    controller.totalPages.value > 0
                        ? controller.totalPages.value.toDouble() - 1
                        : 0,
                  ),
                  activeColor: CustomColor.blueColor,
                  inactiveColor: CustomColor.secondary.withAlpha(150),
                  onChanged: (value) {
                    final validPage = value.toInt().clamp(0, controller.totalPages.value - 1);
                    controller.currentPage.value = validPage;
                    controller.pdfController?.jumpToPage(validPage);
                    print('📄 Slider: Page ${validPage + 1}/${controller.totalPages.value}');
                  },
                  onChangeEnd: (value) {
                    controller.saveProgress();
                  },
                ),
          ),

          // Reading progress percentage
          // Obx(
          //   () => Text(
          //     "${(controller.readingProgress * 100).toStringAsFixed(0)}% read",
          //     style: TextStyle(
          //       color: controller.isDark.value
          //           ? Colors.white
          //           : Colors.black,
          //       fontSize: 14,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),

          // Dark Mode Toggle
          IconButton(
            onPressed: () {
              controller.isDark.value = !controller.isDark.value;
            },
            icon: Obx(
                  () => Icon(
                controller.isDark.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: controller.isDark.value
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
