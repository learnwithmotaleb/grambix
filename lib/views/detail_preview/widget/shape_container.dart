part of '../screen/detail_preview_screen.dart';

class ShapeContainer extends GetView<DetailPreviewController> {
  const ShapeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final data = controller.singleData.first;
    controller.isFav.value = data.isSaved ?? false;

    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return "$hours:$minutes:$seconds";
    }

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
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
          if (data.audioFile.isNotEmpty && data.pdfFile.isNotEmpty) ...[
            const SelectButton(),
          ] else if (data.audioFile.isNotEmpty) ...[
            _buildTopTag("Audio Book"),
          ] else if (data.pdfFile.isNotEmpty) ...[
            _buildTopTag(Strings.ebook),
          ],

          Space.height.v15,
          _audioIconHeader(),
          Space.height.v20,
          _downloadButton(),
          TextWidget(
            Strings.synopsis,
            color: CustomColor.whiteColor,
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.verticalSize * 0.5,
            ),
          ),

          /// --- Synopsis Text
          ExpandableTextWidget(
            text: data.synopsis,
            color: CustomColor.secondary,
            trimLines: 5,
          ),

          /// --- Duration / Page count
          Obx(() {
            String displayText;
            final isEbookSelected = controller.isEbook.value == 0;

            if (!isEbookSelected && data.audioFile.isNotEmpty) {
              // Audio selected
              displayText =
                  "${Strings.duration}${formatDuration(controller.totalDuration.value)}";
            } else if (isEbookSelected && data.pdfFile.isNotEmpty) {
              // Ebook selected
              displayText = "${Strings.totalPage}${data.totalPages}";
            } else if (data.audioFile.isNotEmpty) {
              // Fallback: if audio exists but Ebook selected incorrectly
              displayText =
                  "${Strings.duration}${formatDuration(controller.totalDuration.value)}";
            } else if (data.pdfFile.isNotEmpty) {
              // Fallback: if pdf exists but Audio selected incorrectly
              displayText = "${Strings.totalPage}${data.totalPages}";
            } else {
              displayText = "";
            }

            return TextWidget(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.verticalSize * 0.5,
              ),
              displayText,
              color: CustomColor.secondary,
              fontSize: Dimensions.titleSmall,
            );
          }),
        ],
      ),
    );
  }

  /// 🔹 Top Tag (AudioBook / Ebook)
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

  /// 🔹 Download + Start Button
  Widget _downloadButton() {
    final data = controller.singleData.first;

    return Obx(() {
      // --- Button text calculate
      String buttonText;
      bool isPdf = false;
      bool isAudio = false;

      if (controller.isEbook.value == 0 && data.pdfFile.isNotEmpty) {
        buttonText = Strings.startReading;
        isPdf = true;
      } else if (data.audioFile.isNotEmpty) {
        buttonText = Strings.startListening;
        isAudio = true;
      } else {
        buttonText = Strings.confirm;
      }

      return Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          /// --- Download Button
          controller.isDownloading.value ? LoadingWidget() : DownloadButton(),

          Space.width.v10,

          /// --- Start Button
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (isPdf) {
                Get.toNamed(Routes.readingScreen, arguments: data);
              } else if (isAudio) {
                Get.toNamed(Routes.playerScreen, arguments: data);
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
          ),
        ],
      );
    });
  }

  /// 🔹 Audio / Ebook Icon + Favorite
  Widget _audioIconHeader() {
    final data = controller.singleData.first;

    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        if (data.audioFile.isNotEmpty && data.pdfFile.isNotEmpty) ...[
          SvgPicture.asset(Assets.icons.music, height: 12.h),
        ] else if (data.audioFile.isNotEmpty) ...[
          SvgPicture.asset(Assets.icons.headphone, height: 12.h),
        ] else ...[
          SvgPicture.asset(Assets.icons.glass, height: 12.h),
        ],

        /// --- Favorite Button
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            controller.isFav.value = !controller.isFav.value;
            controller.saveBookMark();
          },
          child: Obx(
                () => Icon(
              controller.isFav.value ? Icons.bookmark : Icons.bookmark_border,
              color: controller.isFav.value
                  ? CustomColor.primary
                  : CustomColor.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
