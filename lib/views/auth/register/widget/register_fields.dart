part of '../screen/register_screen.dart';

class RegisterFields extends GetView<RegisterController> {
  const RegisterFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Space.height.betweenInputBox,
        Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            Expanded(
              child: PrimaryInputWidget(
                fillColor: CustomColor.secondary.withAlpha(95),
                isFilled: true,
                skipEnterPrefix: true,
                label: Strings.firstName,
                radius: Dimensions.radius * 0.95,
                controller: controller.firstNameController,
                hintText: Strings.firstName,
              ),
            ),
            Space.width.v15,
            Expanded(
              child: PrimaryInputWidget(
                skipEnterPrefix: true,
                fillColor: CustomColor.secondary.withAlpha(95),
                isFilled: true,
                label: Strings.lastName,
                radius: Dimensions.radius * 0.95,
                controller: controller.lastNameController,
                hintText: Strings.lastName,
              ),
            ),
          ],
        ),
        Space.height.betweenInputBox,
        PrimaryInputWidget(
          fillColor: CustomColor.secondary.withAlpha(95),
          isFilled: true,
          skipEnterPrefix: true,
          label: Strings.emailAddress,
          radius: Dimensions.radius * 0.95,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: CustomColor.secondary,
            size: Dimensions.iconSizeLarge * 0.85,
          ),
          controller: controller.emailController,
          hintText: Strings.emailAddress,
        ),
        Space.height.betweenInputBox,
        PrimaryInputWidget(
          fillColor: CustomColor.secondary.withAlpha(95),
          isFilled: true,
          skipEnterPrefix: true,
          label: Strings.createPassword,
          radius: Dimensions.radius * 0.95,
          isPasswordField: true,
          controller: controller.passwordController,
          hintText: Strings.createPassword,
        ),
        Space.height.betweenInputBox,
        TextWidget(
          padding: EdgeInsetsGeometry.only(
            bottom: Dimensions.spaceBetweenInputTitleAndBox * 0.8,
          ),
          Strings.selectYourCountry,
          fontSize: Dimensions.titleMedium,
          style: CustomStyle.labelSmall.copyWith(fontWeight: FontWeight.w500),
          color: CustomColor.whiteColor,
        ),
        CustomCountryPicker(selectedCountry: controller.selectedCountry),

        Space.height.betweenInputBox,
        Space.height.betweenInputBox,
        Space.height.betweenInputBox,
        Space.height.betweenInputBox,
      ],
    );
  }
}
