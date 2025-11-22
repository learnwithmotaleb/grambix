part of 'faq_screen.dart';

class FaqScreenMobile extends GetView<FaqController> {
  const FaqScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "FAQ"),
      body: SafeArea(
        child: Obx(
          () => controller.faqList.isEmpty
              ? EmptyDataWidget()
              : controller.isLoading.value
              ? LoadingWidget()
              : SingleChildScrollView(
                  child: Padding(
                    padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
                    child: Column(
                      crossAxisAlignment: crossStart,
                      children: List.generate(controller.faqList.length, (
                        index,
                      ) {
                        final faq = controller.faqList[index];
                        return Column(
                          children: [
                            _buildFaqItem(
                              title: faq.question,
                              content: faq.description,
                              isExpanded:
                                  controller.expandedIndex.value == index,
                              onTap: () => controller.toggleExpand(index),
                            ),
                            _buildDivider(),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildFaqItem({
    required String title,
    required String content,
    required bool isExpanded,
    required Function onTap,
  }) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextWidget(
                    title,
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? null : 0,
          child: isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    content,
                    style: const TextStyle(color: Colors.white70),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(color: Colors.grey, height: 1);
  }
}
