import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/core/utils/basic_import.dart';
import 'package:grambix/views/navigations/library/model/all_save_post_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:grambix/core/languages/strings.dart';

class LibraryController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  List textButtonList = [Strings.all, "Audio Book", 'E-book'];
  var downloadedItems = <Map<String, dynamic>>[].obs;

  late File listFile;

  @override
  void onInit() {
    super.onInit();
    initStorage();
  }

  Future<void> initStorage() async {
    final dir = await getApplicationDocumentsDirectory();
    listFile = File('${dir.path}/downloads_list.json');
    await loadDownloads();
  }

  /// সব ডাউনলোড cache থেকে লোড করবে
  Future<void> loadDownloads() async {
    if (await listFile.exists()) {
      try {
        final content = await listFile.readAsString();
        if (content.isNotEmpty) {
          downloadedItems.value = List<Map<String, dynamic>>.from(
            jsonDecode(content),
          );
        } else {
          downloadedItems.clear();
        }
      } catch (e) {
        downloadedItems.clear();
      }
    } else {
      downloadedItems.clear();
    }
  }

  /// cache file update করার helper method
  Future<void> _saveDownloads() async {
    final data = jsonEncode(downloadedItems);
    await listFile.writeAsString(data);
  }

  /// ডিলিট
  Future<void> deleteDownload(Map<String, dynamic> item) async {
    try {
      // cache/local file delete করা
      if (item["pdf"] != null) {
        final pdfFile = File(item["pdf"]);
        if (await pdfFile.exists()) {
          await pdfFile.delete();
        }
      }

      if (item["audio"] != null) {
        final audioFile = File(item["audio"]);
        if (await audioFile.exists()) {
          await audioFile.delete();
        }
      }

      if (item["image"] != null) {
        final imageFile = File(item["image"]);
        if (await imageFile.exists()) {
          await imageFile.delete();
        }
      }

      // list থেকে remove
      downloadedItems.remove(item);

      // cache update
      await _saveDownloads();
      CustomSnackBar.success(
        title: 'Removed',
        message: 'File deleted successfully',
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Delete failed: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// নতুন ডাউনলোড save করার জন্য
  Future<void> addDownload(Map<String, dynamic> item) async {
    downloadedItems.add(item);
    await _saveDownloads();
  }


}
