import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/routes/routes.dart';
import '../../../core/languages/strings.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../../widgets/otp_input_field.dart';
import '../../../widgets/primary_button_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../auth/login/widget/app_logo_widget.dart';
import '../controller/otp_controller.dart';

part 'otp_screen_mobile.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: OtpScreenMobile());
  }
}
