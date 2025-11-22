part of '../screen/profile_screen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.radius * 1.5),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.horizontalSize,
        vertical: Dimensions.verticalSize * 0.5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: Dimensions.widthSize * 4.2,
              height: Dimensions.heightSize * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius),
                color: Colors.white,
              ),
            ),
          ),
          Space.height.v20,
          TextWidget(
            Strings.logOutAlert,
            typographyStyle: TypographyStyle.titleSmall,
            fontWeight: FontWeight.bold,
            color: CustomColor.whiteColor,
            padding: EdgeInsets.only(bottom: Dimensions.verticalSize * 0.15),
          ),
          TextWidget(
            Strings.areYouSure,
            color: CustomColor.whiteColor,

            typographyStyle: TypographyStyle.bodyMedium,
          ),
          Space.height.betweenInputBox,
          PrimaryButtonWidget(
            title: Strings.cancel,

            onPressed: () {
              Get.close(1);
            },
            buttonColor: CustomColor.secondary,
            borderColor: CustomColor.secondary,
            buttonTextColor: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.verticalSize * 0.6,
            ),
            child: PrimaryButtonWidget(
              title: Strings.logOut,
              buttonTextColor: CustomColor.whiteColor,
              fontWeight: FontWeight.w600,
              onPressed: () {
                AppStorage.clear();
                Get.offAllNamed(Routes.loginScreen);
              },
              // isLoading: Get.put(LoginController()).isLoading.value,
              // onPressed: () {
              //   Get.put(LoginController()).logOutProcess();
              // },
              buttonColor: Colors.red,
              borderColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
