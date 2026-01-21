part of '../screen/profile_screen.dart';

class ProfileImageWidget extends GetView<ProfileController> {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Obx(() {
                final profile = controller.profileInfo.value?.user;
                final hasProfilePicture =
                    profile?.profilePicture != null &&
                    profile!.profilePicture.isNotEmpty;
                return Container(
                  width: 110.w,
                  height: 110.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CustomColor.primary.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: hasProfilePicture
                        ? CachedNetworkImage(
                            imageUrl: profile.profilePicture,
                            fit: BoxFit.cover,
                            width: 110.w,
                            height: 110.h,
                            placeholder: (context, url) => Container(
                              color: CustomColor.secondary.withOpacity(0.1),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: CustomColor.primary,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: CustomColor.secondary.withOpacity(0.1),
                              child: Icon(
                                Icons.person,
                                size: 55.h,
                                color: CustomColor.secondary,
                              ),
                            ),
                          )
                        : Container(
                            color: CustomColor.secondary.withOpacity(0.1),
                            child: Icon(
                              Icons.person,
                              size: 55.h,
                              color: CustomColor.secondary,
                            ),
                          ),
                  ),
                );
              }),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Get.toNamed(Routes.updateProfileScreen),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.paddingSize * 0.35),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColor.primary,
                      border: Border.all(
                        color: CustomColor.whiteColor,
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blackColor.withOpacity(0.15),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: CustomColor.whiteColor,
                      size: Dimensions.iconSizeDefault * 1.1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.verticalSize * 0.3),
          Obx(() {
            final profile = controller.profileInfo.value?.user;
            return TextWidget(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.verticalSize * 0.2,
              ),
              '${profile?.firstName} ${profile?.lastName}' ?? 'No Name',
              color: CustomColor.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.titleMedium * 1.2,
            );
          }),
        ],
      ),
    );
  }
}
