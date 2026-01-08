part of '../screen/player_screen.dart';

class BottomMusicBar extends GetView<PlayerController> {
  const BottomMusicBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.defaultHorizontalSize,
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dynamic song title example
            TextWidget(
              padding: EdgeInsets.only(bottom: Dimensions.verticalSize * 2.5),
              controller.selectedItem.bookName,
              fontSize: Dimensions.titleLarge,
              fontWeight: FontWeight.w600,
              color: CustomColor.whiteColor,
            ),
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
                max: controller.totalDuration.value.inSeconds.toDouble(),
                value: controller.sliderValue.value,
                onChanged: controller.seekTo,
              ),
            ),
            Space.height.v5,
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

            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                const SizedBox(),
                Tooltip(
                  message: 'Rewind 10 seconds',
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: controller.rewind,
                    child: SvgPicture.asset(Assets.icons.backWard),
                  ),
                ),
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
              SizedBox()
              ],
            ),
            Space.height.v20,
          ],
        ),
      ),
    );
  }
}
