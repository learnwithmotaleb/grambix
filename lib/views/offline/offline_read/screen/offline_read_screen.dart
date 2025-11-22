import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:pdfx/pdfx.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/layout.dart';
import '../../../../widgets/auth_app_bar.dart';
import '../../../../widgets/text_widget.dart';
import '../controller/offline_read_controller.dart';
part 'offline_read_screen_mobile.dart';

class OfflineReadScreen extends GetView<OfflineReadController> {
  const OfflineReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: OfflineReadScreenMobile());
  }
}
