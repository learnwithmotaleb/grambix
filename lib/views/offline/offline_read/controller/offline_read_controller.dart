import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

class OfflineReadController extends GetxController {
  var currentPage = 1.obs;
  var totalPages = 0.obs;

  late String pdfPath;
  late String title;
  late String image;
  var isDark = false.obs;

  PdfControllerPinch? pdfController; // nullable

  @override
  void onInit() {
    super.onInit();

    final args = (Get.arguments ?? {}) as Map<String, dynamic>;

    pdfPath = args['savePdf']?.toString() ?? '';
    title = args['Title']?.toString() ?? 'No Title';
    image = args['image']?.toString() ?? '';

    print('✅ PDF Arguments: $args');

    _initPdf();
  }

  void _initPdf() {
    pdfController = PdfControllerPinch(
      document: PdfDocument.openFile(pdfPath), // ✅ Correct
      initialPage: 1,
    );

    // total page বের করতে
    PdfDocument.openFile(pdfPath).then((doc) {
      totalPages.value = doc.pagesCount;
    });
  }

  void toggleTheme() => isDark.value = !isDark.value;

  @override
  void onClose() {
    pdfController?.dispose();
    super.onClose();
  }
}
