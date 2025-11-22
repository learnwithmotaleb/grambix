import 'package:grambix/routes/routes.dart';
import 'package:grambix/views/auth/login/controller/login_controller.dart';
import '../../../../core/utils/basic_import.dart';
import '../../../../core/utils/space.dart';
import '../../../../widgets/primary_button_widget.dart';
import '../../../../widgets/text_widget.dart';

class Button extends GetView<LoginController> {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      children: [
        Obx(
          () => PrimaryButtonWidget(
            isLoading: controller.isLoading.value,
            title: Strings.login,
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                controller.loginProcess();
              }
            },
          ),
        ),
        Space.height.v15,
        Row(
          mainAxisAlignment: mainCenter,
          children: [
            TextWidget(Strings.dontHaveANAccount, color: CustomColor.secondary),

            Space.width.v5,
            TextWidget(
              onTap: () => Get.toNamed(Routes.registerScreen),
              Strings.signUpNow,
              color: CustomColor.primary,
            ),
          ],
        ),

      ],
    );
  }
}
