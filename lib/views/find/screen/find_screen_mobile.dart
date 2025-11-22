part of 'find_screen.dart';

class FindScreenMobile extends GetView<FindController> {
  const FindScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.searchBook),
      body: SafeArea(
        child: Column(
          children: [
            Space.height.v15,
            Padding(
              padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
              child: SerachBoxWidget(),
            ),

            Expanded(
              child: Obx(() {
                return controller.searchResults.isEmpty
                    ? const EmptyDataWidget()
                    : const SerchItems();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
