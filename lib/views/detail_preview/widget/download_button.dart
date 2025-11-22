import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/core/themes/token.dart';
import 'package:grambix/core/utils/dimensions.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../controller/detail_preview_controller.dart';

class DownloadButton extends StatelessWidget {
  DownloadButton({super.key});

  final DetailPreviewController controller =
      Get.find<DetailPreviewController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.verticalSize * 0.25,
        horizontal: Dimensions.defaultHorizontalSize * 1.5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.primary, width: 1.5),
        borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
      ),
      child: InkWell(
        onTap: () async {
          if (controller.singleData.isNotEmpty) {
            await controller.downloadItem(controller.singleData.first);
          } else {
            Get.snackbar(
              "Error",
              "No data available to download",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        child: TextWidget(
          Strings.download,
          color: CustomColor.primary,
          fontSize: Dimensions.titleLarge * 0.8,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
