import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/core/themes/token.dart';
import 'package:grambix/widgets/auth_app_bar.dart';
import 'package:grambix/widgets/empty_data_widget.dart';
import 'package:grambix/widgets/loading_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/policy_controller.dart';
part 'policy_screen_mobile.dart';

class PolicyScreen extends GetView<PolicyController> {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: PolicyScreenMobile());
  }
}
