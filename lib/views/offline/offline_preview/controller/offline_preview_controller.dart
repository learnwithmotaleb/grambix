import 'dart:io';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/api/end_point/api_end_points.dart';

class OfflinePreviewController extends GetxController {
  final player = AudioPlayer();
  List textButtonList = ['E-Book', 'Audio Book'];

  /// Reactive states
  RxBool isFav = false.obs;
  var isExpanded = false.obs;
  RxInt isEbook = 0.obs; // 0 = PDF, 1 = Audio
  Rx<Duration> totalDuration = Duration.zero.obs;

  /// Arguments
  late final Map<String, dynamic> args;

  /// Fields
  late final String title;
  late final String synopsis;
  String pdf = '';
  String audio = '';
  String image = '';
  late final int totalPage;

  @override
  void onInit() {
    super.onInit();

    args = (Get.arguments ?? {}) as Map<String, dynamic>;

    title = args["title"]?.toString() ?? "No Title";
    synopsis = args["synopsis"]?.toString() ?? "";
    pdf = args["pdf"]?.toString() ?? '';
    audio = args["audio"]?.toString() ?? '';
    image = args["image"]?.toString() ?? '';
    totalPage = int.tryParse(args["totalPage"]?.toString() ?? "0") ?? 0;

    // Determine ebook or audio
    isEbook.value = audio.isNotEmpty ? 1 : 0;

    // Load audio duration if audio exists
    if (audio.isNotEmpty) {
      _loadAudioDuration(audio);
    }

    print("✅ Offline Preview Arguments: $args");
  }

  /// Toggle expanded for synopsis
  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  /// Load audio duration (async, handles local/offline & online)
  Future<void> _loadAudioDuration(String audioPath) async {
    try {
      if (audioPath.isEmpty) return;

      final file = File(audioPath);
      if (await file.exists()) {
        await player.setFilePath(audioPath);
      } else {
        final url = audioPath;
        await player.setUrl(url);
      }

      totalDuration.value = player.duration ?? Duration.zero;
      print("🎧 Audio duration loaded: ${totalDuration.value}");
    } catch (e) {
      totalDuration.value = Duration.zero;
      print("❌ Error loading audio duration: $e");
    }
  }

  /// Dispose player
  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
