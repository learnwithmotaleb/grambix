import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/preview_controller.dart';

part 'preview_screen_mobile.dart';

class PreviewScreen extends GetView<PreviewController> {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: PreviewScreenMobile());
  }
}
