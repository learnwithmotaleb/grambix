part of '../screen/detail_preview_screen.dart';

class ShapeContainer extends GetView<DetailPreviewController> {
  const ShapeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final data = controller.singleData.first;
    controller.isFav.value = data.isSaved ?? false;

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
          _buildContentTypeTag(data),
          Space.height.v15,
          _buildIconHeader(data),
          Space.height.v20,
          _buildActionButtons(data),
          _buildSynopsisSection(data),
          _buildDurationOrPageCount(data),
        ],
      ),
    );
  }

  Widget _buildContentTypeTag(data) {
    if (data.audioFile.isNotEmpty && data.pdfFile.isNotEmpty) {
      return const SelectButton();
    } else if (data.audioFile.isNotEmpty) {
      return _buildTopTag("Audio Book");
    } else if (data.pdfFile.isNotEmpty) {
      return _buildTopTag(Strings.ebook);
    }
    return SizedBox.shrink();
  }

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

  Widget _buildIconHeader(data) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        _buildContentIcon(data),
        _buildFavoriteButton(),
      ],
    );
  }

  Widget _buildContentIcon(data) {
    if (data.audioFile.isNotEmpty && data.pdfFile.isNotEmpty) {
      return SvgPicture.asset(Assets.icons.music, height: 12.h);
    } else if (data.audioFile.isNotEmpty) {
      return SvgPicture.asset(Assets.icons.headphone, height: 12.h);
    } else {
      return SvgPicture.asset(Assets.icons.glass, height: 12.h);
    }
  }

  Widget _buildFavoriteButton() {
    return InkWell(
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
    );
  }

  Widget _buildActionButtons(data) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        DownloadButton(),
        Space.width.v10,
        Obx(() {
          final buttonText = _getButtonText(data);
          final isPdf = controller.isEbook.value == 0 && data.pdfFile.isNotEmpty;
          final isAudio = data.audioFile.isNotEmpty;

          return _buildStartButton(buttonText, isPdf, isAudio, data);
        }),
      ],
    );
  }

  String _getButtonText(data) {
    if (controller.isEbook.value == 0 && data.pdfFile.isNotEmpty) {
      return Strings.startReading;
    } else if (data.audioFile.isNotEmpty) {
      return Strings.startListening;
    } else {
      return Strings.confirm;
    }
  }

  Widget _buildStartButton(String buttonText, bool isPdf, bool isAudio, data) {
    return InkWell(
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
    );
  }

  Widget _buildSynopsisSection(data) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget(
          Strings.synopsis,
          color: CustomColor.whiteColor,
          fontWeight: FontWeight.w600,
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.verticalSize * 0.5,
          ),
        ),
        ExpandableTextWidget(
          text: data.synopsis,
          color: CustomColor.secondary,
          trimLines: 5,
        ),
      ],
    );
  }

  Widget _buildDurationOrPageCount(data) {
    return Obx(() {
      final displayText = _getDurationOrPageText(data);

      return TextWidget(
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.verticalSize * 0.5,
        ),
        displayText,
        color: CustomColor.secondary,
        fontSize: Dimensions.titleSmall,
      );
    });
  }

  String _getDurationOrPageText(data) {
    final isEbookSelected = controller.isEbook.value == 0;

    if (!isEbookSelected && data.audioFile.isNotEmpty) {
      return "${Strings.duration}${_formatDuration(controller.totalDuration.value)}";
    } else if (isEbookSelected && data.pdfFile.isNotEmpty) {
      return "${Strings.totalPage}${data.totalPages}";
    } else if (data.audioFile.isNotEmpty) {
      return "${Strings.duration}${_formatDuration(controller.totalDuration.value)}";
    } else if (data.pdfFile.isNotEmpty) {
      return "${Strings.totalPage}${data.totalPages}";
    } else {
      return "";
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}