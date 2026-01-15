import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/core/utils/basic_import.dart';
import 'package:grambix/views/detail_preview/model/single_post_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../../navigations/library/model/download_model.dart';
import '../model/book_mark_model.dart';

class DetailPreviewController extends GetxController {
  List textButtonList = ['E-Book', 'Audio Book'];
  Rx<Duration> totalDuration = Duration.zero.obs;
  final player = AudioPlayer();
  late dynamic selectedId;

  RxBool both = false.obs;
  RxInt isEbook = RxInt(0);
  RxBool isFav = false.obs;
  var isExpanded = false.obs;

  RxBool isLoading = false.obs;
  Set<Data> singleData = {};

  RxBool isDownloading = false.obs;
  RxDouble downloadProgress = 0.0.obs;

  RxList<DownloadedItem> downloadedItems = <DownloadedItem>[].obs;

  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    selectedId = Get.arguments;
    getPreviewData().then((_) {
      if (singleData.isNotEmpty && singleData.first.audioFile.isNotEmpty) {
        getDuration(singleData.first.audioFile);
        checkOfflineFile(singleData.first.audioFile);
      }
    });
  }

  /// Check if audio is already downloaded
  Future<void> checkOfflineFile(String audioFile) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/${audioFile.split('/').last}");
    if (file.existsSync()) {
      print("Offline file found: ${file.path}");
    }
  }

  /// Get audio duration (online or offline)
  Future<void> getDuration(String audioPath) async {
    try {
      final url = audioPath;
      await player.setUrl(url);
      totalDuration.value = player.duration ?? Duration.zero;
    } catch (e) {
      totalDuration.value = Duration.zero;
      print('Error loading audio: $e');
    }
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  /// Download
  Future<void> downloadItem(Data item) async {
    try {
      isDownloading.value = true;
      downloadProgress.value = 0.0;

      final dir = await getApplicationDocumentsDirectory();

      String? audioPath;
      String? pdfPath;
      String? imagePath;

      int totalFiles = 0;
      int completedFiles = 0;

      // Calculate total files to download
      if (item.audioFile.isNotEmpty) totalFiles++;
      if (item.pdfFile.isNotEmpty) totalFiles++;
      if (item.bookCover.isNotEmpty) totalFiles++;

      // 1️⃣ Download Audio
      if (item.audioFile.isNotEmpty) {
        final audioFileName = item.audioFile.split('/').last;
        final audioFile = File('${dir.path}/$audioFileName');
        await dio.download(
          item.audioFile,
          audioFile.path,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              final fileProgress = received / total;
              downloadProgress.value =
                  (completedFiles + fileProgress) / totalFiles;
            }
          },
        );
        audioPath = audioFile.path;
        completedFiles++;
        downloadProgress.value = completedFiles / totalFiles;
      }

      // 2️⃣ Download PDF
      if (item.pdfFile.isNotEmpty) {
        final pdfFileName = item.pdfFile.split('/').last;
        final pdfFile = File('${dir.path}/$pdfFileName');
        await dio.download(
          item.pdfFile,
          pdfFile.path,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              final fileProgress = received / total;
              downloadProgress.value =
                  (completedFiles + fileProgress) / totalFiles;
            }
          },
        );
        pdfPath = pdfFile.path;
        completedFiles++;
        downloadProgress.value = completedFiles / totalFiles;
      }

      // 3️⃣ Download Image
      if (item.bookCover.isNotEmpty) {
        final imgFileName = item.bookCover.split('/').last;
        final imgFile = File('${dir.path}/$imgFileName');
        await dio.download(
          item.bookCover,
          imgFile.path,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              final fileProgress = received / total;
              downloadProgress.value =
                  (completedFiles + fileProgress) / totalFiles;
            }
          },
        );
        imagePath = imgFile.path;
        completedFiles++;
        downloadProgress.value = completedFiles / totalFiles;
      }

      // 4️⃣ Save Metadata
      final metaData = {
        "id": item.id,
        "title": item.bookName,
        "synopsis": item.synopsis,
        "audio": audioPath,
        "pdf": pdfPath,
        "image": imagePath,
        "totalPage": item.totalPages,
      };

      final metaFile = File('${dir.path}/${item.id}_meta.json');
      await metaFile.writeAsString(jsonEncode(metaData));

      final listFile = File('${dir.path}/downloads_list.json');
      List<dynamic> downloads = [];
      if (await listFile.exists()) {
        final content = await listFile.readAsString();
        downloads = jsonDecode(content);
      }

      downloads.removeWhere((d) => d["id"] == item.id);
      downloads.add(metaData);

      await listFile.writeAsString(jsonEncode(downloads));

      downloadProgress.value = 1.0;
      isDownloading.value = false;

      CustomSnackBar.success(
        title: 'Success',
        message: 'All resources downloaded for offline use!',
      );

      print("✅ Downloaded & Added to List: $metaData");
    } catch (e) {
      isDownloading.value = false;
      downloadProgress.value = 0.0;
      CustomSnackBar.error("Download failed");
      print('❌ Download error: $e');
    }
  }
  /// Fetch preview data
  Future<SinglePostModel> getPreviewData() async {
    return await ApiRequest.get(
      queryParams: {'id': selectedId},
      endPoint: ApiEndPoints.singlePost,
      isLoading: isLoading,
      fromJson: SinglePostModel.fromJson,
      onSuccess: (result) {
        singleData.add(result.data);
      },
    );
  }

  //bookMark

  RxBool isBookMarkLoad = false.obs;

  Future<BookMarkModel> saveBookMark() async {
    return await ApiRequest.post(
      fromJson: BookMarkModel.fromJson,
      endPoint: ApiEndPoints.bookMark,
      isLoading: isBookMarkLoad,
      body: {},
      queryParams: {'id': selectedId},
      onSuccess: (result) {
      },
    );


  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
