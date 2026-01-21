part of 'update_profile_screen.dart';

class UpdateProfileScreenMobile extends GetView<UpdateProfileController> {
  const UpdateProfileScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.editProfile),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.betweenInputBox,
            Center(
              child: Stack(
                children: [
                  Obx(() {
                    final selectedFile = controller.selectedImg.value;
                    final profilePicture = controller.profileController.profileInfo.value?.user?.profilePicture;
                    final hasNetworkImage = profilePicture != null && profilePicture.isNotEmpty;

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
                        child: selectedFile != null
                            ? Image.file(
                          selectedFile,
                          width: 110.w,
                          height: 110.h,
                          fit: BoxFit.cover,
                        )
                            : hasNetworkImage
                            ? CachedNetworkImage(
                          imageUrl: profilePicture,
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
                      onTap: controller.pickImg,
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
            ),
            Space.height.v40,

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
              validator: Helpers.emailValidator,
              fillColor: CustomColor.secondary.withAlpha(95),
              isFilled: true,
              label: Strings.phonNumber,
              radius: Dimensions.radius * 0.95,
              controller: controller.phoneController,
              hintText: Strings.phonNumber,
            ),

            // Space.height.betweenInputBox,
            // PrimaryInputWidget(
            //   validator: Helpers.emailValidator,
            //   fillColor: CustomColor.secondary.withAlpha(95),
            //   isFilled: true,
            //   label: Strings.selectYourCountry,
            //   radius: Dimensions.radius * 0.95,
            //   controller: TextEditingController(),
            //   hintText: Strings.email,
            // ),
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,

            Obx(
              () => PrimaryButtonWidget(
                isLoading: controller.isLoading.value,
                title: Strings.saveChanges,
                onPressed: () => controller.updateProfile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
