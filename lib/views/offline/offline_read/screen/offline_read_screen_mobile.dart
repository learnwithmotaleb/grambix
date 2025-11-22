part of 'offline_read_screen.dart';

class OfflineReadScreenMobile extends GetView<OfflineReadController> {
  const OfflineReadScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              margin: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                border: Border.all(
                  color: controller.isDark.value ? Colors.white : Colors.black,
                ),
              ),
              child: Icon(
                Icons.arrow_back,
                color: controller.isDark.value ? Colors.white : Colors.black,
                size: Dimensions.iconSizeDefault,
              ),
            ),
          ),
          backgroundColor: controller.isDark.value
              ? Colors.black
              : Colors.white,
          iconTheme: IconThemeData(
            color: controller.isDark.value ? Colors.white : Colors.black,
          ),
          title: Text(
            controller.title,
            style: TextStyle(
              color: controller.isDark.value ? Colors.white : Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                controller.isDark.value ? Icons.light_mode : Icons.dark_mode,
                color: controller.isDark.value ? Colors.white : Colors.black,
              ),
              onPressed: controller.toggleTheme,
            ),
          ],
        ),

        // 📄 PDF Viewer
        body: Obx(() {
          if (controller.pdfController == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            color: controller.isDark.value ? Colors.black : Colors.white,
            child: ColorFiltered(
              colorFilter: controller.isDark.value
                  ? const ColorFilter.matrix([
                      -1, 0, 0, 0, 255, // invert Red
                      0, -1, 0, 0, 255, // invert Green
                      0, 0, -1, 0, 255, // invert Blue
                      0, 0, 0, 1, 0, // keep Alpha
                    ])
                  : const ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.multiply,
                    ),
              child: PdfViewPinch(
                controller: controller.pdfController!, // null safe
                scrollDirection: Axis.vertical,
                backgroundDecoration: BoxDecoration(
                  color: controller.isDark.value ? Colors.black : Colors.white,
                ),
                onPageChanged: (page) {
                  controller.currentPage.value = page;
                },
              ),
            ),
          );
        }),

        // 📑 Page Navigation
        bottomNavigationBar: Obx(
          () => Container(
            padding: const EdgeInsets.all(12),
            color: controller.isDark.value ? Colors.black87 : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Page ${controller.currentPage.value} / ${controller.totalPages.value}",
                  style: TextStyle(
                    color: controller.isDark.value
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: () {
                        controller.pdfController?.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        color: controller.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: () {
                        controller.pdfController?.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
