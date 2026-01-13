import 'package:grambix/views/reading/controller/reading_controller.dart';
import 'package:pdfx/pdfx.dart';
import '../../../core/utils/basic_import.dart';

class ReadTextWidgt extends GetView<ReadingController> {
  const ReadTextWidgt({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Check if pdfController is null
      if (controller.pdfController == null) {
        return const Center(child: Text("Failed to load PDF"));
      }

      return ColorFiltered(
        colorFilter: controller.isDark.value
            ? const ColorFilter.matrix([
          -1, 0, 0, 0, 255, // invert Red
          0, -1, 0, 0, 255, // invert Green
          0, 0, -1, 0, 255, // invert Blue
          0, 0, 0, 1, 0,    // keep Alpha
        ])
            : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
        child: PdfViewPinch(
          controller: controller.pdfController!,
          scrollDirection: Axis.vertical,
          backgroundDecoration: BoxDecoration(
            color: controller.isDark.value ? Colors.black : Colors.white,
          ),
          onPageChanged: (page) {
            controller.setCurrentPage(page); // ✅ Use safe setter
          },
        ),
      );
    });
  }
}
