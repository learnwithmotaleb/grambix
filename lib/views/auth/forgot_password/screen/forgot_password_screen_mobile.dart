part of 'forgot_password_screen.dart';

class ForgotPasswordScreenMobile extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.forgotPassword),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsetsGeometry.only(
            top: MediaQuery.of(context).size.height * 0.14,
            left: Dimensions.defaultHorizontalSize,
            right: Dimensions.defaultHorizontalSize,
          ),
          children: [
            AppLogoWidget(),
            TextWidget(
              Strings.enterYourEmailToResetYourPass,
              color: CustomColor.whiteColor,
            ),
            Space.height.betweenInputBox,
            PrimaryInputWidget(
              fillColor: CustomColor.secondary.withAlpha(95),
              isFilled: true,
              label: Strings.email,
              radius: Dimensions.radius * 0.95,
              controller: controller.emailController,
              hintText: Strings.email,
            ),
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,
            Obx(
              () => PrimaryButtonWidget(
                isLoading: controller.isLoading.value,
                title: Strings.submit,
                onPressed: () {
                  controller.forgetPasswordProcess();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
