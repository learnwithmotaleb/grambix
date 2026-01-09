import 'dart:io';
import 'package:get/get.dart';
import 'package:grambix/core/api/model/basic_success_model.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/utils/basic_import.dart';
import '../model/book.dart';
import 'package:grambix/views/detail_preview/model/single_post_model.dart';
import 'dart:typed_data';

class ReadingController extends GetxController {
  late final Data info;

  PdfControllerPinch? pdfController;
  var isLoading = true.obs;
  var isDark = false.obs;
  var currentPage = 0.obs;
  var totalPages = 0.obs;

  late String pdfUrl;

  @override
  void onInit() {
    super.onInit();
    info = Get.arguments as Data;
    pdfUrl = info.pdfFile;
    loadPdf();
  }

  double get readingProgress {
    if (totalPages.value == 0) return 0.0;
    return (currentPage.value + 1) / totalPages.value;
  }

  /// Load PDF from network safely
  void loadPdf() async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(pdfUrl));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // Initialize the controller with the PDF bytes
        pdfController = PdfControllerPinch(
          document: PdfDocument.openData(bytes),
          initialPage: 1,
        );

        // Get total pages
        final doc = await pdfController!.document;
        totalPages.value = doc.pagesCount;
      } else {
        print("Failed to load PDF: ${response.statusCode}");
        Get.snackbar("Error", "Failed to load PDF");
      }
    } catch (e) {
      print("PDF Load Error: $e");
      Get.snackbar("Error", "Failed to load PDF");
    } finally {
      isLoading.value = false;
    }
  }


  // set progress
  RxBool progressSending =  false.obs;
  Future<BasicSuccessModel> saveProgress() async {
    return ApiRequest.put(fromJson: BasicSuccessModel.fromJson,
        endPoint: "${ApiEndPoints.savingReadingProgress}${info.id}/progress",
        isLoading: progressSending,
        body: {
          "currentPage": currentPage.value,
          "totalPages": totalPages.value,
          "currentTime": 0,
          "totalDuration": 0,
          "progress": readingProgress
        }


  );
}


/// Dispose safely
@override
void onClose() {
  pdfController?.dispose();
  super.onClose();
}}
