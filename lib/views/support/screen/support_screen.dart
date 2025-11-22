import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/basic_import.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/support_controller.dart';

part 'support_screen_mobile.dart';

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: SupportScreenMobile());
  }
}
