import 'package:flutter/foundation.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import 'package:grambix/widgets/text_widget.dart';

import '../../../core/utils/basic_import.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../payment/screen/payment_screen.dart';
import '../../processe_payement_google/screen/in_app_purchase.dart';
import '../../processe_payement_google/controller/revenue_card.dart';
import '../controller/sp_controller.dart';

part 'sp_screen_mobile.dart';

class SpScreen extends GetView<SpController> {
  const SpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: SpScreenMobile());
  }
}
