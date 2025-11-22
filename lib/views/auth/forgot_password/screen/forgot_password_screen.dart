import 'package:grambix/core/utils/space.dart';
import 'package:grambix/routes/routes.dart';
import 'package:grambix/views/auth/login/widget/app_logo_widget.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../../core/utils/basic_import.dart';
import '../controller/forgot_password_controller.dart';
part 'forgot_password_screen_mobile.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ForgotPasswordScreenMobile());
  }
}
