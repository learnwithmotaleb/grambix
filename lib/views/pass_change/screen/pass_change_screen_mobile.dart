part of 'pass_change_screen.dart';

class PassChangeScreenMobile extends GetView<PassChangeController> {
  const PassChangeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.changePassword),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.betweenInputBox,
            PrimaryInputWidget(
              fillColor: CustomColor.secondary.withAlpha(95),
              isFilled: true,
              skipEnterPrefix: true,
              label: Strings.currentPassword,
              radius: Dimensions.radius * 0.95,
              isPasswordField: true,
              controller: controller.passwordController,
              hintText: '',
            ),
            Space.height.betweenInputBox,
            PrimaryInputWidget(
              fillColor: CustomColor.secondary.withAlpha(95),
              isFilled: true,
              skipEnterPrefix: true,
              label: Strings.newPassword,
              radius: Dimensions.radius * 0.95,
              isPasswordField: true,
              controller: controller.newPasswordController,
              hintText: '',
            ),

            Space.height.betweenInputBox,
            PrimaryInputWidget(
              fillColor: CustomColor.secondary.withAlpha(95),
              isFilled: true,
              skipEnterPrefix: true,
              label: Strings.confirmPassword,
              radius: Dimensions.radius * 0.95,
              isPasswordField: true,
              controller: controller.confirmPasswordController,
              hintText: '',
            ),

            Space.height.betweenInputBox,
            Space.height.betweenInputBox,

            Obx(
              () => PrimaryButtonWidget(
                isLoading: controller.isLoading.value,
                title: Strings.saveChanges,
                onPressed: () => controller.changePasswordProcess(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
