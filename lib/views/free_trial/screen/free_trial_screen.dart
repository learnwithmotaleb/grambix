import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grambix/core/themes/token.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/res/assets.dart';
import 'package:grambix/routes/routes.dart';
import 'package:grambix/widgets/auth_app_bar.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/free_trial_controller.dart';

part 'free_trial_screen_mobile.dart';

class FreeTrialScreen extends GetView<FreeTrialController> {
  const   FreeTrialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: FreeTrialScreenMobile());
  }
}
