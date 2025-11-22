import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/widgets/auth_app_bar.dart';
import 'package:grambix/widgets/empty_data_widget.dart';
import 'package:grambix/widgets/loading_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/faq_controller.dart';

part 'faq_screen_mobile.dart';

class FaqScreen extends GetView<FaqController> {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: FaqScreenMobile());
  }
}
