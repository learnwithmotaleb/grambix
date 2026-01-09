import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/views/detail_preview/model/single_post_model.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/api/model/basic_success_model.dart';
import '../../../core/api/services/api_request.dart';

class PlayerController extends GetxController {
  final player = AudioPlayer();

  // List of song URLs
  final List<String> songUrls = [];

  RxInt currentSongIndex = 0.obs;
  late Data selectedItem;



  RxDouble sliderValue = 0.0.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  Rx<Duration> currentPosition = Duration.zero.obs;
  RxBool isPlaying = false.obs;

  late ConcatenatingAudioSource playlist;

  @override
  void onInit() {
    super.onInit();
    selectedItem = Get.arguments as Data;
    songUrls.add(selectedItem.audioFile);
    preloadSongs();
  }

  Future<void> preloadSongs() async {
    try {
      print(
        '******************************************************************************',
      );
      print(songUrls.first);
      print(songUrls.length);
      playlist = ConcatenatingAudioSource(
        children: songUrls
            .map((url) => AudioSource.uri(Uri.parse(url)))
            .toList(),
      );

      await player.setAudioSource(playlist);

      totalDuration.value = player.duration ?? Duration.zero;

      player.positionStream.listen((pos) {
        currentPosition.value = pos;
        sliderValue.value = pos.inSeconds.toDouble();
      });

      player.playerStateStream.listen((state) {
        isPlaying.value = state.playing;
      });

      player.durationStream.listen((duration) {
        totalDuration.value = duration ?? Duration.zero;
      });

      player.currentIndexStream.listen((index) {
        if (index != null) currentSongIndex.value = index;
      });
    } catch (e) {
      print('Audio preload error: $e');
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

  void nextSong() {
    if (currentSongIndex.value < songUrls.length - 1) {
      player.seekToNext();
    }
  }

  void previousSong() {
    if (currentSongIndex.value > 0) {
      player.seekToPrevious();
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }









  // set progress
  RxBool progressSending =  false.obs;
  Future<BasicSuccessModel> saveProgress() async {
    return ApiRequest.put(fromJson: BasicSuccessModel.fromJson,
        endPoint: "${ApiEndPoints.savingReadingProgress}${selectedItem.id}/progress",
        isLoading: progressSending,
        body: {
          "currentPage": 0,
          "totalPages": 0,
          "currentTime": currentPosition.value,
          "totalDuration": totalDuration.value,
          "progress": sliderValue.value
        }


    );
  }






  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
