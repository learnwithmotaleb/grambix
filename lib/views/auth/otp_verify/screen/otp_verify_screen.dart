import 'package:grambix/routes/routes.dart';
import 'package:grambix/widgets/otp_input_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/utils/basic_import.dart';
import '../../../../core/utils/space.dart';
import '../../../../widgets/primary_button_widget.dart';
import '../../../../widgets/text_widget.dart';
import '../../login/widget/app_logo_widget.dart';
import '../controller/otp_verify_controller.dart';

part 'otp_verify_screen_mobile.dart';

class OtpVerifyScreen extends GetView<OtpVerifyController> {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: OtpVerifyScreenMobile());
  }
}
