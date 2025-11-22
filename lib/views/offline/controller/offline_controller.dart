import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class OfflineController extends GetxController {
  late String audioPath;
  late String title;
  late String image;
  late String synopsis;

  final player = AudioPlayer();

  RxDouble sliderValue = 0.0.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  Rx<Duration> currentPosition = Duration.zero.obs;
  RxBool isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();

    final args = (Get.arguments ?? {}) as Map<String, dynamic>;

    audioPath = args['saveAudio']?.toString() ?? '';
    title = args['Title']?.toString() ?? 'No Title';
    image = args['image']?.toString() ?? '';
    synopsis = args['synopsis']?.toString() ?? '';

    print('✅ Audio Arguments: $args');

    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      // লোকাল path বা network URL দুটোই সাপোর্ট করবে
      await player.setFilePath(audioPath);

      // total duration listen
      player.durationStream.listen((d) {
        if (d != null) {
          totalDuration.value = d;
        }
      });

      // current position listen
      player.positionStream.listen((p) {
        currentPosition.value = p;
        sliderValue.value = p.inSeconds.toDouble();
      });

      // play/pause status listen
      player.playerStateStream.listen((state) {
        isPlaying.value = state.playing;
      });
    } catch (e) {
      print("❌ Error loading audio: $e");
    }
  }

  void togglePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void seekTo(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  void rewind() {
    player.seek(player.position - const Duration(seconds: 10));
  }

  void forward() {
    player.seek(player.position + const Duration(seconds: 10));
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
