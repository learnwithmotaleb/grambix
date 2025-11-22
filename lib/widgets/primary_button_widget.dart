import 'package:grambix/widgets/text_widget.dart';

import '../core/utils/basic_import.dart';
import 'loading_widget.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? borderColor;
  final double borderWidth;
  final double? height;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final OutlinedBorder? shape;
  final Widget? icon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isLoading;
  final bool primary;
  final bool disable;
  final EdgeInsets? padding;

  PrimaryButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderColor,
    this.borderWidth = 0,
    this.height,
    this.buttonColor,
    this.buttonTextColor,
    this.shape,
    this.icon,
    this.fontSize,
    this.fontWeight,
    this.isLoading = false,
    this.primary = false,
    this.disable = false,
    this.padding,
  });

  final ValueNotifier<bool> isPadding = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const LoadingWidget();
    return ValueListenableBuilder<bool>(
      valueListenable: isPadding,
      builder: (context, isPadded, _) {
        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: isPadded ? 5 : 0),
            height: height ?? Dimensions.buttonHeight * 0.8,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                isPadding.value = true;
                Future.delayed(const Duration(milliseconds: 220), () {
                  isPadding.value = false;
                });
                onPressed();
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor:
                    (disable ? CustomColor.disableColor : buttonColor) ??
                    CustomColor.primary,
                shape:
                    shape ??
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius * 1.2,
                      ),
                    ),
                side: BorderSide(
                  width: borderWidth,
                  color: disable
                      ? CustomColor.disableColor
                      : borderColor ?? CustomColor.primary,
                ),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                child: TextWidget(
                  title,
                  fontSize: isPadded
                      ? (fontSize ?? Dimensions.titleMedium)
                      : fontSize ?? Dimensions.titleMedium * 1.1,
                  fontWeight: fontWeight ?? FontWeight.w900,
                  color: primary
                      ? CustomColor.primary
                      : buttonTextColor ?? Colors.black,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
