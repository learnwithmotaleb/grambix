part of 'profile_screen.dart';

class ProfileScreenMobile extends GetView<ProfileController> {
  const ProfileScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.myProfile, isBack: false),
      body: Obx(
        () => controller.isLoading.value ? LoadingWidget() : _bodyWidget(),
      ),
    );
  }

  _bodyWidget() {
    return SafeArea(
      child: ListView(
        padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
        children: [
          ProfileImageWidget(),
          Space.height.v20,
          ProfileSectionHeading(),
        ],
      ),
    );
  }
}
