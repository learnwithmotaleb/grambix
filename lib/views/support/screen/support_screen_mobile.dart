part of 'support_screen.dart';

class SupportScreenMobile extends GetView<SupportController> {
  const SupportScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Support"),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            PrimaryInputWidget(
              controller: TextEditingController(),
              hintText: 'Write here',
              skipEnterPrefix: true,
            ),
            Space.height.betweenInputBox,
            PrimaryInputWidget(
              controller: TextEditingController(),
              hintText: 'Write here',
              mxLine: 5,
              skipEnterPrefix: true,
            ),
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,

            PrimaryButtonWidget(title: Strings.submit, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
