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

                return CircleAvatar(
                  radius: Dimensions.radius * 5,
                  backgroundColor: CustomColor.secondary,
                  child: ClipOval(
                    child:
                        (profile?.profilePicture != null &&
                            profile!.profilePicture.isNotEmpty
                        ? Image.network(
                            profile.profilePicture,
                            height: 110.h,
                            width: 110.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person,
                              size: 110,
                              color: CustomColor.secondary,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 110,
                            color: CustomColor.secondary,
                          )),
                  ),
                );
              }),
              // 📷 Camera icon
              Positioned(
                bottom: 4,
                right: 0,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Get.toNamed(Routes.updateProfileScreen),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.paddingSize * 0.1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: CustomColor.whiteColor.withAlpha(88),
                      ),
                      color: CustomColor.secondary,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: CustomColor.primary,
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
              profile?.firstName ?? 'No Name',
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
