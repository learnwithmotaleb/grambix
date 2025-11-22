import 'dart:io';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/core/themes/token.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/res/assets.dart' hide Icons;
import 'package:grambix/views/navigations/navigation/widget/bottom_bar_widget.dart';
import 'package:grambix/views/reading/widget/read_text_widgt.dart';
import 'package:grambix/widgets/auth_app_bar.dart';
import 'package:grambix/widgets/loading_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import 'package:pdfx/pdfx.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/reading_controller.dart';
import 'package:grambix/views/detail_preview/model/single_post_model.dart';
part '../widget/bottom_widget.dart';
part 'reading_screen_mobile.dart';

class ReadingScreen extends GetView<ReadingController> {
  const ReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ReadingScreenMobile());
  }
}
