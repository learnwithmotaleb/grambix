import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grambix/core/helpers/helpers.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/res/assets.dart';
import 'package:grambix/views/auth/login/widget/app_logo_widget.dart';
import 'package:grambix/views/auth/login/widget/button.dart';
import 'package:grambix/views/auth/login/widget/fields_section.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import 'package:grambix/widgets/primary_input_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../../core/themes/token.dart';
import '../../../../core/utils/custom_style.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/layout.dart';
import '../controller/login_controller.dart';
part 'login_screen_mobile.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: LoginScreenMobile());
  }
}
