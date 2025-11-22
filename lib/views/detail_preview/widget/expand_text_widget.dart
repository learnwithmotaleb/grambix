import 'package:grambix/core/utils/basic_import.dart';
import 'package:grambix/views/detail_preview/controller/detail_preview_controller.dart';
import 'package:grambix/views/offline/offline_preview/controller/offline_preview_controller.dart';

class ExpandableTextWidget extends GetView<DetailPreviewController> {
  final String text;
  final Color color;
  final int trimLines;

  const ExpandableTextWidget({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.trimLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: color,
      fontSize: Dimensions.titleSmall,
      height: 1.5, // Better readability
    );

    // Calculate overflow just once
    final span = TextSpan(text: text, style: textStyle);
    final tp = TextPainter(
      text: span,
      maxLines: trimLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 40); // Padding considered

    final isOverflowing = tp.didExceedMaxLines;

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: textStyle,
            maxLines: controller.isExpanded.value ? null : trimLines,
            overflow: controller.isExpanded.value
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
          ),
          if (isOverflowing)
            GestureDetector(
              onTap: controller.toggleExpanded,
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  controller.isExpanded.value
                      ? Strings.close.tr
                      : Strings.readMore.tr,
                  style: TextStyle(
                    fontSize: Dimensions.titleSmall,
                    color: CustomColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}

class ExpandableTextWidgetTwo extends GetView<OfflinePreviewController> {
  final String text;
  final Color color;
  final int trimLines;

  const ExpandableTextWidgetTwo({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.trimLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: color,
      fontSize: Dimensions.titleSmall,
      height: 1.5, // Better readability
    );

    // Calculate overflow just once
    final span = TextSpan(text: text, style: textStyle);
    final tp = TextPainter(
      text: span,
      maxLines: trimLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 40); // Padding considered

    final isOverflowing = tp.didExceedMaxLines;

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: textStyle,
            maxLines: controller.isExpanded.value ? null : trimLines,
            overflow: controller.isExpanded.value
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
          ),
          if (isOverflowing)
            GestureDetector(
              onTap: controller.toggleExpanded,
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  controller.isExpanded.value
                      ? Strings.close.tr
                      : Strings.readMore.tr,
                  style: TextStyle(
                    fontSize: Dimensions.titleSmall,
                    color: CustomColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
