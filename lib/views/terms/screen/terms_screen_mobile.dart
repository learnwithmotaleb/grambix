part of 'terms_screen.dart';

class TermsScreenMobile extends GetView<TermsController> {
  const TermsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.terms.value);
    return Scaffold(
      appBar: CommonAppBar(title: Strings.termsAndConditions),
      body: Obx(
            () => controller.isLoading.value
            ? LoadingWidget()
            : SingleChildScrollView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          child: Html(
            data: controller.terms.value.tr,
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
