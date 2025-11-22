part of 'otp_screen.dart';

class OtpScreenMobile extends GetView<OtpController> {
  const OtpScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.verifyCode),
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

            TextWidget(
              textAlign: TextAlign.center,
              Strings.enterCode,
              color: CustomColor.whiteColor,
            ),
            Space.height.betweenInputBox,

            OtpInputField(controller: controller.otpController),
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,

            PrimaryButtonWidget(
              title: Strings.submit,
              onPressed: () {
                Get.toNamed(Routes.resetPasswordScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
