import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/basic_import.dart';
import '../../../../widgets/text_widget.dart';
import '../controller/navigation_controller.dart';

class BottomBarWidget extends StatelessWidget {
  BottomBarWidget({
    super.key,
    this.icon,
    required this.label,
    this.index,
    this.path,
    this.svgSize,
  });

  final IconData? icon;
  final String? path;
  final String label;
  final int? index;
  final double? svgSize;

  final controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        if (index != null) controller.selectedIndex.value = index!;
      },
      child: Obx(() {
        final isSelected = controller.selectedIndex.value == index;
        return SizedBox(
          width: Dimensions.widthSize * 5.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: isSelected
                      ? CustomColor.primary
                      : CustomColor.disableColor,
                  size: Dimensions.iconSizeDefault * 1.2,
                )
              else if (path != null)
                SvgPicture.asset(
                  path!,
                  height: svgSize ?? Dimensions.iconSizeDefault * 1.2,
                  width: svgSize ?? Dimensions.iconSizeDefault * 1.2,
                  color: isSelected
                      ? CustomColor.primary
                      : CustomColor.disableColor,
                ),
              SizedBox(height: Dimensions.verticalSize * 0.3),
              TextWidget(
                label,
                style: TextStyle(
                  fontSize: Dimensions.labelSmall,
                  fontWeight: FontWeight.w500,
                ),
                color: isSelected
                    ? CustomColor.primary
                    : CustomColor.disableColor,
              ),
            ],
          ),
        );
      }),
    );
  }
}
