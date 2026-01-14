part of '../screen/player_screen.dart';

class BottomMusicBar extends GetView<PlayerController> {
  const BottomMusicBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.defaultHorizontalSize,
      ),
      child: Obx(() {
        // ✅ Loading check সরিয়ে দিলাম - শুধু normal UI থাকবে

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dynamic song title
            TextWidget(
              padding: EdgeInsets.only(bottom: Dimensions.verticalSize * 2.5),
              controller.selectedItem.bookName,
              fontSize: Dimensions.titleLarge,
              fontWeight: FontWeight.w600,
              color: CustomColor.whiteColor,
            ),

            // Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2.0,
                activeTrackColor: CustomColor.primary,
                inactiveTrackColor: CustomColor.secondary,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                thumbColor: CustomColor.whiteColor,
              ),
              child: Slider(
                padding: EdgeInsetsGeometry.zero,
                min: 0,
                // ✅ Max value - minimum 1 second to avoid division by zero
                max: controller.totalDuration.value.inSeconds
                    .toDouble()
                    .clamp(1.0, double.infinity),

                // ✅ Value clamp করো
                value: controller.sliderValue.value.clamp(
                  0.0,
                  controller.totalDuration.value.inSeconds
                      .toDouble()
                      .clamp(1.0, double.infinity),
                ),

                onChanged: controller.seekTo,
              ),
            ),

            Space.height.v5,

            // Time display
            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                TextWidget(
                  controller.formatDuration(controller.currentPosition.value),
                  color: CustomColor.secondary,
                ),
                TextWidget(
                  controller.formatDuration(controller.totalDuration.value),
                  color: CustomColor.secondary,
                ),
              ],
            ),

            Space.height.v10,

            // Control buttons
            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                const SizedBox(),

                // Rewind button
                Tooltip(
                  message: 'Rewind 10 seconds',
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: controller.rewind,
                    child: SvgPicture.asset(Assets.icons.backWard),
                  ),
                ),

                // Play/Pause button
                Tooltip(
                  message: controller.isPlaying.value ? 'Pause' : 'Play',
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: controller.togglePlayPause,
                    child: CircleAvatar(
                      backgroundColor: CustomColor.primary,
                      child: Icon(
                        controller.isPlaying.value
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: CustomColor.background,
                      ),
                    ),
                  ),
                ),

                // Forward button
                Tooltip(
                  message: 'Forward 10 seconds',
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: controller.forward,
                    child: Transform.rotate(
                      angle: 3.1416,
                      child: SvgPicture.asset(Assets.icons.backWard),
                    ),
                  ),
                ),

                const SizedBox(),
              ],
            ),

            Space.height.v20,
          ],
        );
      }),
    );
  }
}