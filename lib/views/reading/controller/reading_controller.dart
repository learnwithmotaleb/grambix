import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:grambix/core/api/model/basic_success_model.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/utils/basic_import.dart';
import '../model/book.dart';
import 'package:grambix/views/detail_preview/model/single_post_model.dart';

class ReadingController extends GetxController {
  late final Data info;

  PdfControllerPinch? pdfController;
  var isLoading = true.obs;
  var isDark = false.obs;
  var currentPage = 0.obs;
  var totalPages = 0.obs;

  late String pdfUrl;

  int? initialPage;

  Timer? _autoSaveTimer;

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;

    if (arguments is Map<String, dynamic>) {
      info = arguments['item'] as Data;

      if (arguments.containsKey('currentPage') &&
          arguments['currentPage'] != null) {
        initialPage = arguments['currentPage'] as int;
        print('📖 Resuming from page: ${initialPage! + 1}');
      }
    } else if (arguments is Data) {
      info = arguments;
      initialPage = null;
      print('📖 Starting from page 1');
    } else {
      print('❌ Invalid arguments');
      Get.back();
      CustomSnackBar.error('Invalid book data');
      return;
    }

    pdfUrl = info.pdfFile;
    loadPdf();
    _startAutoSave();
  }

  double get readingProgress {
    if (totalPages.value == 0) return 0.0;
    return (currentPage.value + 1) / totalPages.value;
  }

  void setCurrentPage(int page) {
    if (totalPages.value <= 0) {
      print('⚠️ Total pages not loaded yet');
      return;
    }

    final validPage = page.clamp(0, totalPages.value - 1);

    if (validPage != page) {
      print('⚠️ Page $page out of range, clamped to $validPage');
    }

    currentPage.value = validPage;
    print('📄 Current: Page ${validPage + 1}/${totalPages.value}');
  }

  void loadPdf() async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(pdfUrl));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final tempDoc = await PdfDocument.openData(bytes);
        final actualTotalPages = tempDoc.pagesCount;

        totalPages.value = actualTotalPages;

        print('📄 Backend says: ${info.totalPages} pages');
        print('📄 Actual PDF has: $actualTotalPages pages');

        int startPage = 0;
        if (initialPage != null && actualTotalPages > 0) {
          if (initialPage! >= 0 && initialPage! < actualTotalPages) {
            startPage = initialPage!;
            print(
              '✅ Resuming from saved page: ${startPage + 1}/$actualTotalPages',
            );
          } else {
            startPage = actualTotalPages - 1;
            print('⚠️ Saved page (${initialPage! + 1}) is out of range');
            print(
              '📖 Adjusted to last page: ${startPage + 1}/$actualTotalPages',
            );
          }
        } else {
          print('📖 Starting from page 1');
        }

        pdfController = PdfControllerPinch(
          document: PdfDocument.openData(bytes),
          initialPage: startPage + 1,
        );

        currentPage.value = startPage;
      } else {
        print("❌ Failed to load PDF: ${response.statusCode}");
        CustomSnackBar.error('Failed to load PDF');
      }
    } catch (e) {
      print("❌ PDF Load Error: $e");
      CustomSnackBar.error('Failed to load PDF: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _startAutoSave() {
    _autoSaveTimer = Timer.periodic(Duration(seconds: 20), (timer) {
      if (currentPage.value > 0 && !progressSending.value) {
        saveProgress();
        print('🔄 Auto-saving: Page ${currentPage.value + 1}');
      }
    });
  }

  RxBool progressSending = false.obs;

  Future<BasicSuccessModel> saveProgress() async {
    print('💾 Saving progress:');
    print('   Current Page: ${currentPage.value + 1}');
    print('   Total Pages: ${totalPages.value}');
    print('   Progress: ${(readingProgress * 100).round()}%');

    final contentType = _getContentType();

    print('   Content Type: $contentType');

    return ApiRequest.put(
      fromJson: BasicSuccessModel.fromJson,
      endPoint:
      "${ApiEndPoints.savingReadingProgress}$contentType/${info.id}/progress",
      isLoading: progressSending,
      body: {
        "currentPage": currentPage.value,
        "totalPages": totalPages.value,
        "progress": (readingProgress * 100).round(),
      },
    );
  }

  String _getContentType() {
    final hasPdf = info.pdfFile.isNotEmpty;
    final hasAudio = info.audioFile.isNotEmpty;

    print('🔍 Checking content type:');
    print('   Has PDF: $hasPdf');
    print('   Has Audio: $hasAudio');

    // ✅ Both PDF and Audio available
    if (hasPdf && hasAudio) {
      print('✅ Content Type: book (both formats)');
      return 'book';
    }
    // ✅ Only PDF available
    else if (hasPdf) {
      print('✅ Content Type: ebook');
      return 'ebook';
    }
    // ✅ Only Audio available
    else if (hasAudio) {
      print('✅ Content Type: audiobook');
      return 'audiobook';
    }
    // ✅ Default fallback
    else {
      print('⚠️ Content Type: book (default)');
      return 'book';
    }
  }

  @override
  void onClose() async {
    _autoSaveTimer?.cancel();

    if (currentPage.value > 0) {
      print('💾 Final save on exit: Page ${currentPage.value + 1}');
      await saveProgress();
      print('✅ Progress saved successfully');
    }

    pdfController?.dispose();
    super.onClose();
  }
}