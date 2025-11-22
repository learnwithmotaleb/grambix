part of 'reset_password_screen.dart';

class ResetPasswordScreenMobile extends GetView<ResetPasswordController> {
  const ResetPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.setANewPass),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsetsGeometry.only(
            top: MediaQuery.of(context).size.height * 0.14,
            left: Dimensions.defaultHorizontalSize,
            right: Dimensions.defaultHorizontalSize,
          ),
          children: [
            AppLogoWidget(),
            Space.height.betweenInputBox,

            Space.height.betweenInputBox,
            PrimaryInputWidget(
              fillColor: CustomColor.secondary.withAlpha(95),
              isFilled: true,
              label: Strings.createPassword,
              isPasswordField: true,
              radius: Dimensions.radius * 0.95,
              controller: controller.passwordController,
              hintText: Strings.password,
            ),
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,

            Obx(
              () => PrimaryButtonWidget(
                isLoading: controller.isLoading.value,
                title: Strings.confirm,
                onPressed: () {
                  controller.resetPasswordProcess();
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
