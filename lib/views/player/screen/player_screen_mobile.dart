part of 'player_screen.dart';

class PlayerScreenMobile extends GetView<PlayerController> {
  const PlayerScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(() =>
      (controller.isLoadingData.value || controller.isLoadingAudio.value)
          ? const SizedBox.shrink()
          : SafeArea(child: BottomMusicBar())
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
            controller.saveProgress();
          },
          icon: Icon(
            Icons.keyboard_arrow_down_sharp,
            size: Dimensions.iconSizeLarge,
            color: CustomColor.whiteColor,
          ),
        ),
      ),
      body: Obx(() {
        // ✅ Full screen loading - data বা audio load হচ্ছে
        if (controller.isLoadingData.value || controller.isLoadingAudio.value) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Background
              Image.asset(Assets.logo.dummy, fit: BoxFit.cover),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 60, sigmaY: 50),
                child: Container(
                  color: CustomColor.whiteColor.withOpacity(0.05),
                ),
              ),

              // ✅ Center loading indicator
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: CustomColor.primary,
                      strokeWidth: 3,
                    ),
                    Space.height.v15,
                    TextWidget(
                      controller.isLoadingData.value
                          ? 'Loading book details...'
                          : 'Loading audio...',
                      color: CustomColor.whiteColor,
                      fontSize: Dimensions.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        // ✅ Normal UI - Everything loaded
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(Assets.logo.dummy, fit: BoxFit.cover),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 50),
              child: Container(
                color: CustomColor.whiteColor.withOpacity(0.05),
              ),
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
                  borderRadius:
                  BorderRadius.circular(Dimensions.radius * 0.8),
                ),
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(Dimensions.radius * 0.8),
                  child: CachedNetworkImage(
                    imageUrl: controller.selectedItem.bookCover,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: CustomColor.primary,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: CustomColor.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
