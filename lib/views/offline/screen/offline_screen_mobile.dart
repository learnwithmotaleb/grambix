part of 'offline_screen.dart';

class OfflineScreenMobile extends GetView<OfflineController> {
  const OfflineScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.keyboard_arrow_down_sharp,
            size: Dimensions.iconSizeLarge,
            color: CustomColor.whiteColor,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalSize,
        ),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🎵 Dynamic song title
              TextWidget(
                padding: EdgeInsets.only(bottom: Dimensions.verticalSize * 2.5),
                controller.title,
                fontSize: Dimensions.titleLarge,
                fontWeight: FontWeight.w600,
                color: CustomColor.whiteColor,
              ),

              // 🎚️ Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2.0,
                  activeTrackColor: CustomColor.primary,
                  inactiveTrackColor: CustomColor.secondary,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 5,
                  ),
                  thumbColor: CustomColor.whiteColor,
                ),
                child: Slider(
                  min: 0,
                  max: controller.totalDuration.value.inSeconds.toDouble(),
                  value: controller.sliderValue.value.clamp(
                    0,
                    controller.totalDuration.value.inSeconds.toDouble(),
                  ),
                  onChanged: (value) => controller.seekTo(value),
                ),
              ),

              Space.height.v5,

              // ⏱️ Duration
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

              // 🎵 Controls
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  const SizedBox(),

                  // ⏪ Rewind
                  Tooltip(
                    message: 'Rewind 10 seconds',
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: controller.rewind,
                      child: SvgPicture.asset(Assets.icons.backWard),
                    ),
                  ),

                  // ▶️ / ⏸ Play-Pause
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
                  // ⏩ Forward
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
                  SizedBox(),
                ],
              ),

              Space.height.v40,
            ],
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Assets.logo.dummy, fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 50),
            child: Container(color: CustomColor.whiteColor.withOpacity(0.05)),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.25,
              ),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.55,
              decoration: BoxDecoration(
                border: Border.all(color: CustomColor.secondary),
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
                child: Image.file(
                  File(controller.image),
                  height: 155.h,
                  width: 180.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
