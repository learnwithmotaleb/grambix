import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/widgets/auth_app_bar.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controller/terms_controller.dart';

part 'terms_screen_mobile.dart';

class TermsScreen extends GetView<TermsController> {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: TermsScreenMobile());
  }
}
