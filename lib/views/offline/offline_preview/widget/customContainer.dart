part of '../screen/offline_preview_screen.dart';

class ShapeContainer extends GetView<OfflinePreviewController> {
  const ShapeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.verticalSize,
        horizontal: Dimensions.defaultHorizontalSize,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColor.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.radius * 3),
        ),
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          /// Top Select Button / Ebook / AudioBook
          if (controller.audio.isNotEmpty && controller.pdf.isNotEmpty) ...[
            Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(
                2,
                (index) => InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    controller.isEbook.value = index;
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: Dimensions.defaultHorizontalSize * 0.5,
                        vertical: Dimensions.verticalSize * 0.1,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(
                          Dimensions.radius,
                        ),
                        color: controller.isEbook.value == index
                            ? CustomColor.primary
                            : CustomColor.background,
                        border: Border.all(
                          color: controller.isEbook.value == index
                              ? CustomColor.primary
                              : CustomColor.whiteColor.withAlpha(99),
                        ),
                      ),
                      margin: EdgeInsetsGeometry.only(
                        right: Dimensions.widthSize,
                      ),
                      child: TextWidget(
                        controller.textButtonList[index],
                        fontSize: Dimensions.titleSmall,
                        color: controller.isEbook.value == index
                            ? CustomColor.background
                            : CustomColor.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ] else if (controller.audio.isNotEmpty) ...[
            _buildTopTag("Audio Book"),
          ] else if (controller.pdf.isNotEmpty) ...[
            _buildTopTag("Ebook"),
          ],

          Space.height.v15,
          _audioIconHeader(),
          Space.height.v20,
          _downloadButton(),

          /// Synopsis Title
          TextWidget(
            "Synopsis",
            color: CustomColor.whiteColor,
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.verticalSize * 0.5,
            ),
          ),

          /// Synopsis Text
          ExpandableTextWidgetTwo(
            text: controller.synopsis,
            color: CustomColor.secondary,
            trimLines: 5,
          ),

          /// Duration / Page count
          Obx(() {
            String text;
            final isEbookSelected =
                controller.isEbook.value == 0; // 0 = Ebook, 1 = Audio
            final hasAudio = controller.audio.isNotEmpty;
            final hasPdf =
                controller.totalPage > 0; // assuming totalPage is 0 if no pdf

            if (!isEbookSelected && hasAudio) {
              // Audio selected
              final duration = controller.totalDuration.value;
              String twoDigits(int n) => n.toString().padLeft(2, '0');
              final minutes = twoDigits(duration.inMinutes.remainder(60));
              final seconds = twoDigits(duration.inSeconds.remainder(60));
              text =
                  "Duration: ${duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : ''}$minutes:$seconds";
            } else if (isEbookSelected && hasPdf) {
              // Ebook selected
              text = "Total Page: ${controller.totalPage}";
            } else if (hasAudio) {
              // Fallback if audio exists but Ebook selected incorrectly
              final duration = controller.totalDuration.value;
              String twoDigits(int n) => n.toString().padLeft(2, '0');
              final minutes = twoDigits(duration.inMinutes.remainder(60));
              final seconds = twoDigits(duration.inSeconds.remainder(60));
              text =
                  "Duration: ${duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : ''}$minutes:$seconds";
            } else if (hasPdf) {
              // Fallback if pdf exists but Audio selected incorrectly
              text = "Total Page: ${controller.totalPage}";
            } else {
              text = "";
            }

            return TextWidget(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.verticalSize * 0.5,
              ),
              text,
              color: CustomColor.secondary,
              fontSize: Dimensions.titleSmall,
            );
          }),
        ],
      ),
    );
  }

  /// Top Tag
  Widget _buildTopTag(String text) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalSize,
          vertical: Dimensions.verticalSize * 0.1,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
          color: CustomColor.primary,
          border: Border.all(color: CustomColor.whiteColor.withAlpha(99)),
        ),
        child: TextWidget(
          text,
          fontSize: Dimensions.titleSmall,
          color: CustomColor.blackColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Download / Start Button
  Widget _downloadButton() {
    return Obx(() {
      String buttonText;
      bool isPdf = false;
      bool isAudio = false;

      if (controller.isEbook.value == 0 && controller.pdf.isNotEmpty) {
        buttonText = "Start Reading";
        isPdf = true;
      } else if (controller.audio.isNotEmpty) {
        buttonText = "Start Listening";
        isAudio = true;
      } else {
        buttonText = "Confirm";
      }

      return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (isPdf) {
            Get.toNamed(
              Routes.offlineReadScreen,
              arguments: {'savePdf': controller.pdf, 'Title': controller.title},
            );
          } else if (isAudio) {
            Get.toNamed(
              Routes.offlineScreen,
              arguments: {
                'saveAudio': controller.audio,
                'Title': controller.title,
                'synopsis': controller.synopsis,
                'image': controller.image,
                'duration': controller.totalDuration,
              },
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: CustomColor.primary,
            border: Border.all(color: CustomColor.primary, width: 1.5),
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          ),
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.verticalSize * 0.25,
            horizontal: Dimensions.defaultHorizontalSize * 1.5,
          ),
          child: TextWidget(
            buttonText,
            color: CustomColor.background,
            fontSize: Dimensions.titleLarge * 0.8,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }

  /// Audio / Ebook Icon + Favorite
  Widget _audioIconHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (controller.audio.isNotEmpty && controller.pdf.isNotEmpty) ...[
          SvgPicture.asset(Assets.icons.music, height: 20),
        ] else if (controller.audio.isNotEmpty) ...[
          SvgPicture.asset(Assets.icons.headphone, height: 20),
        ] else ...[
          SvgPicture.asset(Assets.icons.glass, height: 20),
        ],

        /// Favorite
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => controller.isFav.value = !controller.isFav.value,
          child: Obx(
            () => Icon(
              Icons.favorite,
              color: controller.isFav.value
                  ? Colors.red
                  : CustomColor.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
