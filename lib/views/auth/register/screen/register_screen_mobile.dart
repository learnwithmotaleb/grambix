part of 'register_screen.dart';

class RegisterScreenMobile extends GetView<RegisterController> {
  const RegisterScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.createAccount),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            RegisterFields(),
            Obx(
              () => PrimaryButtonWidget(
                isLoading: controller.isLoading.value,
                title: Strings.signUp,
                onPressed: () => controller.registerProcess(),
              ),
            ),
            Space.height.v15,
            Row(
              mainAxisAlignment: mainCenter,
              children: [
                TextWidget(
                  Strings.alreadyHaveAnAccount,
                  color: CustomColor.secondary,
                ),
                Space.width.v5,
                TextWidget(
                  onTap: () => Get.offAllNamed(Routes.loginScreen),
                  Strings.logIn,
                  color: CustomColor.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
