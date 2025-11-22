import 'package:grambix/routes/routes.dart';
import '../../../../core/utils/basic_import.dart';
import '../../../../core/utils/space.dart';
import '../../../../widgets/primary_button_widget.dart';
import '../../login/widget/app_logo_widget.dart';
import '../controller/reset_password_controller.dart';

part 'reset_password_screen_mobile.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ResetPasswordScreenMobile());
  }
}
