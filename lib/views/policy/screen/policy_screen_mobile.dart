part of 'policy_screen.dart';

class PolicyScreenMobile extends GetView<PolicyController> {
  const PolicyScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.privacyPolicy),
      body: Obx(
            () => controller.isLoading.value
            ? LoadingWidget()
            : SingleChildScrollView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          child: Html(
            data: controller.privacyPolicy.value.tr,
            style: {
              "body": Style(
                fontSize: FontSize(Dimensions.titleSmall),
                color: CustomColor.whiteColor.withAlpha(889),
              ),
            },
          ),
        ),
      ),

    );
  }
}
