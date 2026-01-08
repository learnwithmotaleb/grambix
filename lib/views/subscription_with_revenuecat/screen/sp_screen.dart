import 'package:flutter/foundation.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/views/subscription_with_revenuecat/screen/sp_screen_mobile.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/utils/basic_import.dart';
import '../../../widgets/auth_app_bar.dart';
import '../../payment/screen/payment_screen.dart';
import '../controller/revenue_cat_services.dart';
import '../controller/sp_controller.dart';



class SpScreen extends GetView<SpController> {
  const SpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: SpScreenMobile());
  }
}
