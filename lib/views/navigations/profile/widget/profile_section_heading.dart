part of '../screen/profile_screen.dart';

class ProfileSectionHeading extends StatelessWidget {
  const ProfileSectionHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        _sectionHeading(
          Strings.editProfile,
          Assets.icons.editProfile,
          () => Get.toNamed(Routes.updateProfileScreen),
        ),
        _sectionHeading(
          Strings.subscription,
          Assets.icons.subscription,
          () => Get.toNamed(Routes.freeTrialScreen),
        ),
        _sectionHeading(
          Strings.faq,
          Assets.icons.faq,
          () => Get.toNamed(Routes.faqScreen),
        ),
        // _sectionHeading(
        //   Strings.contactSupport,
        //   Assets.icons.supports,
        //   () => Get.toNamed(Routes.supportScreen),
        // ),
        _sectionHeading(
          Strings.changePassword,
          Assets.icons.changeP,
          () => Get.toNamed(Routes.passChangeScreen),
        ),
        // _sectionHeading(Strings.deleteAccount, Assets.icons.userRemove, () {}),
        _sectionHeading(Strings.logOut, Assets.icons.logout, (){
          showModalBottomSheet(
            context: context,


            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Dimensions.radius * 1.5),
              ),
            ),
            builder: (BuildContext context) {
              return LogoutDialog();
            },
          );
        }),
        TextWidget(
          padding: Dimensions.verticalSize.edgeVertical * 0.2,
          Strings.legal,color: CustomColor.whiteColor,fontSize: Dimensions.titleLarge * 0.85,),
        _sectionHeading(
          Strings.termsAndConditions,
          Assets.icons.terms,
          () => Get.toNamed(Routes.termsScreen),
        ),
        _sectionHeading(
          Strings.privacyPolicy,
          Assets.icons.policy,
          () => Get.toNamed(Routes.policyScreen),
        ),
      ],
    );
  }

  _sectionHeading(String title, String path, Function()? onTap) {
    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.verticalSize * 0.2,
            ),
            child: Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                Wrap(
                  spacing: Dimensions.widthSize,
                  children: [
                    SvgPicture.asset(path),
                    TextWidget(title, color: CustomColor.whiteColor),
                  ],
                ),

                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: CustomColor.whiteColor,
                  size: Dimensions.iconSizeDefault,
                ),
              ],
            ),
          ),
        ),
        Divider(color: CustomColor.secondary),
      ],
    );
  }
}
