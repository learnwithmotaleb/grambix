import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../res/assets.dart' hide Icons;
import '../../../widgets/text_widget.dart';
import '../controller/offline_controller.dart';

part 'offline_screen_mobile.dart';

class OfflineScreen extends GetView<OfflineController> {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: OfflineScreenMobile());
  }
}
