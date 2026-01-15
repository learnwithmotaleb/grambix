import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/core/themes/token.dart';
import 'package:grambix/core/utils/dimensions.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/custom_snackbar.dart';
import '../controller/detail_preview_controller.dart';

class DownloadButton extends StatelessWidget {
  DownloadButton({super.key});

  final DetailPreviewController controller = Get.find<DetailPreviewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDownloading = controller.isDownloading.value;
      final progress = controller.downloadProgress.value;

      return InkWell(
        onTap: isDownloading
            ? null
            : () async {
          if (controller.singleData.isNotEmpty) {
            await controller.downloadItem(controller.singleData.first);
          } else {
            CustomSnackBar.error('No data available to download');
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.verticalSize * 0.25,
            horizontal: Dimensions.defaultHorizontalSize * 1.5,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: isDownloading
                  ? CustomColor.primary.withOpacity(0.5)
                  : CustomColor.primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          ),
          child: isDownloading
              ? Row(
            mainAxisSize: mainMin,
            children: [
              SizedBox(
                width: Dimensions.iconSizeDefault,
                height: Dimensions.iconSizeDefault,
                child: CircularProgressIndicator(
                  value: progress > 0 ? progress : null,
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    CustomColor.primary,
                  ),
                ),
              ),
              Space.width.v10,
              TextWidget(
                '${(progress * 100).toInt()}%',
                color: CustomColor.primary,
                fontSize: Dimensions.titleLarge * 0.8,
                fontWeight: FontWeight.w600,
              ),
            ],
          )
              : TextWidget(
            Strings.download,
            color: CustomColor.primary,
            fontSize: Dimensions.titleLarge * 0.8,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }
}