import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/widgets/auth_app_bar.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import 'package:grambix/widgets/primary_input_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/payment_controller.dart';

part 'payment_screen_mobile.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: PaymentScreenMobile());
  }
}
