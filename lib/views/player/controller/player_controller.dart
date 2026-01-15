import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/views/detail_preview/model/single_post_model.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/api/model/basic_success_model.dart';
import '../../../core/api/services/api_request.dart';

class PlayerController extends GetxController {
  final player = AudioPlayer();

  final List<String> songUrls = [];

  RxInt currentSongIndex = 0.obs;
  late Data selectedItem;

  Duration? initialPosition;

  RxDouble sliderValue = 0.0.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  Rx<Duration> currentPosition = Duration.zero.obs;
  RxBool isPlaying = false.obs;

  late ConcatenatingAudioSource playlist;

  RxBool isLoadingData = true.obs;
  RxBool isLoadingAudio = true.obs;

  @override
  void onInit() {
    super.onInit();

    isLoadingData.value = true;

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

    isLoadingData.value = false;

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

      isLoadingAudio.value = false;

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

  RxBool progressSending = false.obs;

  Future<BasicSuccessModel> saveProgress() async {
    print('💾 Saving listening progress:');
    print('   Current Time: ${formatDuration(currentPosition.value)}');
    print('   Total Duration: ${formatDuration(totalDuration.value)}');
    print(
      '   Progress: ${(currentPosition.value.inSeconds / totalDuration.value.inSeconds * 100).round()}%',
    );

    // ✅ Determine content type
    final contentType = _getContentType();

    print('   Content Type: $contentType');

    return ApiRequest.put(
      fromJson: BasicSuccessModel.fromJson,
      endPoint:
      "${ApiEndPoints.savingListeningProgress}$contentType/${selectedItem.id}/progress",
      isLoading: progressSending,
      body: {
        "currentTime": currentPosition.value.inSeconds,
        "progress": (currentPosition.value.inSeconds /
            totalDuration.value.inSeconds *
            100)
            .round(),
      },
    );
  }

  // ✅ Helper method to determine content type
  String _getContentType() {
    final hasPdf = selectedItem.pdfFile.isNotEmpty;
    final hasAudio = selectedItem.audioFile.isNotEmpty;

    // ✅ Both PDF and Audio available
    if (hasPdf && hasAudio) {
      return 'book';
    }
    // ✅ Only PDF available
    else if (hasPdf) {
      return 'ebook';
    }
    // ✅ Only Audio available
    else if (hasAudio) {
      return 'audiobook';
    }
    // ✅ Default fallback
    else {
      return 'book';
    }
  }

  @override
  void onClose() async {
    if (currentPosition.value.inSeconds > 0) {
      print('💾 Final save on exit: ${formatDuration(currentPosition.value)}');
      await saveProgress();
      print('✅ Progress saved successfully');
    }

    player.dispose();
    super.onClose();
  }
}