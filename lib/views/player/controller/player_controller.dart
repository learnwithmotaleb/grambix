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



  Duration? initialPosition;


  RxDouble sliderValue = 0.0.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  Rx<Duration> currentPosition = Duration.zero.obs;
  RxBool isPlaying = false.obs;

  late ConcatenatingAudioSource playlist;




  RxBool isLoadingData = true.obs;  // ✅ Book data loading
  RxBool isLoadingAudio = true.obs; // ✅ Audio loading

  @override
  void onInit() {
    super.onInit();

    isLoadingData.value = true; // ✅ Start loading

    final arguments = Get.arguments;

    if (arguments is Map<String, dynamic>) {
      selectedItem = arguments['item'] as Data;

      if (arguments.containsKey('currentTime') &&
          arguments['currentTime'] != null) {
        final savedTime = arguments['currentTime'] as int;
        initialPosition = Duration(seconds: savedTime);
        print('🎵 Resuming from: ${formatDuration(initialPosition!)}');
      } else {
        initialPosition = null;
      }
    } else if (arguments is Data) {
      selectedItem = arguments;
      initialPosition = null;
      print('🎵 Playing fresh audio');
    } else {
      print('❌ Invalid arguments');
      Get.back();
      Get.snackbar('Error', 'Invalid audio data');
      return;
    }

    isLoadingData.value = false; // ✅ Data loaded

    songUrls.add(selectedItem.audioFile);
    preloadSongs();
  }
  Future<void> preloadSongs() async {
    try {
      isLoadingAudio.value = true;

      print('🎵 Loading audio: ${songUrls.first}');

      playlist = ConcatenatingAudioSource(
        children:
        songUrls.map((url) => AudioSource.uri(Uri.parse(url))).toList(),
      );

      await player.setAudioSource(playlist);

      totalDuration.value = player.duration ?? Duration.zero;
      print('✅ Total duration: ${formatDuration(totalDuration.value)}');

      if (initialPosition != null) {
        await player.seek(initialPosition!);
        sliderValue.value = initialPosition!.inSeconds.toDouble();
        currentPosition.value = initialPosition!;
        print('✅ Seeked to: ${formatDuration(initialPosition!)}');
      }

      isLoadingAudio.value = false; // ✅ Audio loaded

      // Listeners
      player.positionStream.listen((pos) {
        currentPosition.value = pos;
        final maxSeconds = totalDuration.value.inSeconds.toDouble();
        sliderValue.value = pos.inSeconds.toDouble().clamp(0.0, maxSeconds);
      });

      player.playerStateStream.listen((state) {
        isPlaying.value = state.playing;
      });

      player.durationStream.listen((duration) {
        if (duration != null) {
          totalDuration.value = duration;
        }
      });

      player.currentIndexStream.listen((index) {
        if (index != null) currentSongIndex.value = index;
      });
    } catch (e) {
      print('❌ Audio preload error: $e');
      isLoadingAudio.value = false;
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
  RxBool progressSending = false.obs;

  Future<BasicSuccessModel> saveProgress() async {
    return ApiRequest.put(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: "${ApiEndPoints.savingListeningProgress}/${selectedItem.id}/progress",
      isLoading: progressSending,
      body: {
        "currentTime": currentPosition.value.inSeconds,
        "progress": (currentPosition.value.inSeconds /
            totalDuration.value.inSeconds * 100).round(), // ✅ percentage
      },
    );
  }


  @override
  void onClose() {
    print('${ApiEndPoints.savingListeningProgress}/${selectedItem.id}/progress');

    if (currentPosition.value.inSeconds > 0) {
      saveProgress();
      print('💾 Saving progress: ${formatDuration(currentPosition.value)}');
    }

    player.dispose();
    super.onClose();
  }
}
