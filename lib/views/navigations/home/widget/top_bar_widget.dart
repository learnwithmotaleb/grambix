part of '../screen/home_screen.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            Assets.logo.appLogo,
            height: Dimensions.heightSize * 4.5,
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => Get.find<NavigationController>().goToProfile(),
            child: Padding(
              padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
              child: Obx(() {
                final profile = Get.find<ProfileController>().profileInfo.value?.user.profilePicture;

                return CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: profile != null && profile.isNotEmpty ? NetworkImage(profile) : null,
                  child: profile == null || profile.isEmpty
                      ? Icon(Icons.person, color: Colors.grey)
                      : null,
                );
              })
            ),
            ),
        ],
      ),
    );
  }
}
