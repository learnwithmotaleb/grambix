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
                  CircleAvatar(
                    radius: Dimensions.radius * 5,
                    backgroundColor: CustomColor.secondary,
                    child: Obx(() {
                      final file = controller.selectedImg.value;
                      final info = controller.profileController.profileInfo.value?.user;

                      return file == null
                          ? ClipOval(
                        child: file != null
                            ? Image.file(
                          file,
                          height: 110.h,
                          width: 110.w,
                          fit: BoxFit.cover,
                        )
                            : (info?.profilePicture != null &&
                            info!.profilePicture.isNotEmpty
                            ? Image.network(
                          info.profilePicture,
                          height: 110.h,
                          width: 110.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(
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
                      )
                          : ClipOval(
                              child: Image.file(
                                file,
                                height: 110.h,
                                width: 110.w,
                                fit: BoxFit.cover,
                              ),
                            );
                    }),
                  ),

                  Positioned(
                    bottom: 4,
                    right: 0,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.pickImg();
                      },
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
