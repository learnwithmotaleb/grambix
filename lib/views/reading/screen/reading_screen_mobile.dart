part of 'reading_screen.dart';

class ReadingScreenMobile extends GetView<ReadingController> {
  const ReadingScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ✅ Back button চাপার আগে save করো
        if (controller.currentPage.value > 0) {
          print('💾 Saving before exit: Page ${controller.currentPage.value + 1}');
          await controller.saveProgress();
          print('✅ Save completed');
        }
        return true; // Allow back navigation
      },
      child: Obx(
            () => Scaffold(
          backgroundColor: controller.isDark.value ? Colors.black : Colors.white,
          appBar: CommonAppBar(
            isBack: true,
            title: controller.info.bookName,
            titleColor: controller.isDark.value ? Colors.white : Colors.black,
            borderColor: controller.isDark.value ? Colors.white : Colors.black,
            iconColor: controller.isDark.value ? Colors.white : Colors.black,
            backgroundColor: controller.isDark.value ? Colors.black : Colors.white,
          ),
          body: controller.isLoading.value ? LoadingWidget() : ReadTextWidgt(),
          bottomNavigationBar: BottomWidget(),
        ),
      ),
    );
  }
}