import 'package:grambix/core/helpers/helpers.dart';
import 'package:grambix/views/auth/login/controller/login_controller.dart';

import '../../../../core/utils/basic_import.dart';
import '../../../../core/utils/space.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/primary_input_widget.dart';
import '../../../../widgets/text_widget.dart';

class FieldsSection extends GetView<LoginController> {
  const FieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: crossEnd,
        children: [
          Obx(
            () => PrimaryInputWidget(
              validator: Helpers.emailValidator,
              onChanged: controller.onEmailChanged,
              fillColor: CustomColor.secondary.withAlpha(95),
              isFilled: true,
              label: Strings.email,
              radius: Dimensions.radius * 0.95,
              controller: controller.emailController,
              hintText: Strings.email,
              errorText: controller.emailError.value.isEmpty
                  ? null
                  : controller.emailError.value,
            ),
          ),
          Space.height.betweenInputBox,
          PrimaryInputWidget(
            fillColor: CustomColor.secondary.withAlpha(95),
            isFilled: true,
            label: Strings.password,
            isPasswordField: true,
            radius: Dimensions.radius * 0.95,
            controller: controller.passwordController,
            hintText: Strings.password,
          ),
          TextWidget(
            Strings.forgotPassword,
            color: CustomColor.primary,
            onTap: () => Get.toNamed(Routes.forgotPasswordScreen),
            textAlign: TextAlign.end,
            fontSize: Dimensions.titleSmall * 1.1,
            padding: EdgeInsetsGeometry.only(
              bottom: Dimensions.verticalSize * 1.25,
              top: Dimensions.heightSize,
            ),
          ),
        ],
      ),
    );
  }
}
