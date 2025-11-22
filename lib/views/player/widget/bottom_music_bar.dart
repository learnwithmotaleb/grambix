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
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      // transparent modal sheet background
                      barrierColor: Colors.transparent,
                      // no dimming overlay
                      isScrollControlled: true,
                      builder: (context) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 30,
                              sigmaY: 30,
                            ), // blur intensity
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusGeometry.circular(
                                  Dimensions.radius,
                                ),
                                color: CustomColor.background.withOpacity(0.2),
                              ),
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: ListView(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                children: [
                                  TextWidget(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      vertical: Dimensions.verticalSize * 0.5,
                                      horizontal:
                                          Dimensions.defaultHorizontalSize,
                                    ),
                                    'Up Next',
                                    color: CustomColor.whiteColor,
                                  ),

                                  ...List.generate(
                                    10,
                                    (index) => ListTile(
                                      leading: Image.asset(Assets.logo.cardIMG),
                                      title: TextWidget(
                                        'Imagined By You',
                                        color: CustomColor.whiteColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      subtitle: TextWidget(
                                        'By You,',
                                        color: CustomColor.whiteColor,
                                        fontSize: Dimensions.titleSmall * 0.9,
                                      ),
                                      trailing: SvgPicture.asset(
                                        Assets.icons.headphone,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.menu, color: CustomColor.secondary),
                ),
              ],
            ),
            Space.height.v40,
          ],
        ),
      ),
    );
  }
}
