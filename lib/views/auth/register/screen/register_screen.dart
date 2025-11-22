import 'package:country_picker/country_picker.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/widgets/custom_country_picker.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import '../../../../core/utils/basic_import.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/text_widget.dart';
import '../controller/register_controller.dart';

part 'register_screen_mobile.dart';
part '../widget/register_fields.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: RegisterScreenMobile());
  }
}
