import 'package:grambix/widgets/text_widget.dart';
import '../core/utils/basic_import.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBack;

  // ✅ Optional Color Parameters
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final Color? borderColor;

  const CommonAppBar({
    super.key,
    required this.title,
    this.isBack = true,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.borderColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: isBack
          ? GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          margin: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
            border: Border.all(
              color: borderColor ?? CustomColor.whiteColor,
            ),
          ),
          child: Icon(
            Icons.arrow_back,
            color: iconColor ?? CustomColor.whiteColor,
            size: Dimensions.iconSizeDefault,
          ),
        ),
      )
          : null,
      title: TextWidget(
        title,
        color: titleColor ?? CustomColor.whiteColor,
        fontSize: Dimensions.titleMedium * 1.2,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
