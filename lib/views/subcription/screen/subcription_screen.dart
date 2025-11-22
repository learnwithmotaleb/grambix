import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import '../../../core/languages/strings.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/text_widget.dart';
import '../controller/subcription_controller.dart';

part 'subcription_screen_mobile.dart';

class SubcriptionScreen extends GetView<SubcriptionsController> {
  const SubcriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: SubcriptionScreenMobile());
  }
}
