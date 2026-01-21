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
                final profilePicture = Get.find<ProfileController>()
                    .profileInfo
                    .value
                    ?.user
                    .profilePicture;
                final hasImage = profilePicture != null && profilePicture.isNotEmpty;

                return Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CustomColor.primary.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: ClipOval(
                    child: hasImage
                        ? CachedNetworkImage(
                      imageUrl: profilePicture,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: CustomColor.secondary.withOpacity(0.1),
                        child: Center(
                          child: SizedBox(
                            width: 16.w,
                            height: 16.h,
                            child: CircularProgressIndicator(
                              color: CustomColor.primary,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: CustomColor.secondary.withOpacity(0.1),
                        child: Icon(
                          Icons.person,
                          size: 24.h,
                          color: CustomColor.secondary,
                        ),
                      ),
                    )
                        : Container(
                      color: CustomColor.secondary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: 24.h,
                        color: CustomColor.secondary,
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
