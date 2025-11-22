import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/widgets/auth_app_bar.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import '../../../core/languages/strings.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/primary_input_widget.dart';
import '../controller/pass_change_controller.dart';

part 'pass_change_screen_mobile.dart';

class PassChangeScreen extends GetView<PassChangeController> {
  const PassChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: PassChangeScreenMobile());
  }
}
