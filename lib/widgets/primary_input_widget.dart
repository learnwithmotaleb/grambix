import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/widgets/text_widget.dart';

import '../core/utils/basic_import.dart';
import 'custom_image_widget.dart';

enum BorderShapeStyle { outline, underline, none }

enum BorderType { enabled, focused, disabled, error, focusedError }

class PrimaryInputWidget extends StatefulWidget {
  final String hintText;
  final String? errorText;
  final TextEditingController controller;
  final String? label;
  final String? optionalText;
  final String? prefixIconPath;
  final String phoneCode;
  final bool isPasswordField;
  final bool autoFocus;
  final bool readOnly;
  final bool isFilled;
  final bool showBorder;
  final bool useDefaultValidation;
  final bool skipEnterPrefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double borderWidth;
  final double? radius;
  final int? mxLine;
  final double? padding;
  final Color? fillColor;
  final Color? shadowColor;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets? suffixPadding;
  final AlignmentGeometry? alignment;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final BorderShapeStyle borderShape;

  const PrimaryInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.label,
    this.optionalText,
    this.prefixIconPath = "",
    this.phoneCode = "",
    this.isPasswordField = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.isFilled = false,
    this.showBorder = true,
    this.useDefaultValidation = true,
    this.skipEnterPrefix = false,
    this.prefixIcon,
    this.suffixIcon,
    this.borderWidth = 1,
    this.radius,
    this.padding,
    this.fillColor,
    this.shadowColor,
    this.keyboardType,
    this.inputFormatters,
    this.contentPadding,
    this.suffixPadding,
    this.alignment,
    this.onChanged,
    this.validator,
    this.borderShape = BorderShapeStyle.outline,
    this.errorText, this.mxLine,
  });

  @override
  State<PrimaryInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<PrimaryInputWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = true;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final input = _buildTextFormField();

    return widget.alignment != null
        ? Align(alignment: widget.alignment!, child: input)
        : input;
  }

  Widget _buildTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) _buildLabel(),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          readOnly: widget.readOnly,
          autofocus: widget.autoFocus,
          obscureText: widget.isPasswordField ? _obscureText : false,
          style: TextStyle(
            fontSize: Dimensions.bodyLarge,
            color: CustomColor.secondary,
          ),
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          decoration: _buildInputDecoration(),

          validator: widget.validator ?? _defaultValidator(),
          onChanged: widget.onChanged,
          maxLines: widget.mxLine ?? 1,
          cursorColor: CustomColor.secondary,
          onTap: _handleFocus,
          onEditingComplete: _focusNode.unfocus,
          onFieldSubmitted: (_) => _focusNode.unfocus(),
          onTapOutside: (_) => _focusNode.unfocus(),
        ),
      ],
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.spaceBetweenInputTitleAndBox * 0.8,
      ),
      child: Row(
        children: [
          TextWidget(
            widget.label!,
            fontSize: Dimensions.titleMedium,
            style: CustomStyle.labelSmall.copyWith(fontWeight: FontWeight.w500),
            color: CustomColor.whiteColor,
          ),
          if (widget.optionalText?.isNotEmpty ?? false)
            Padding(
              padding: Dimensions.horizontalSize.edgeHorizontal * 0.25,
              child: TextWidget(
                widget.optionalText!,
                fontSize: Dimensions.titleMedium * 0.9,
                style: CustomStyle.labelSmall.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                color: CustomColor.primary,
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    final hint = widget.skipEnterPrefix
        ? widget.hintText
        : '${Strings.enter} ${widget.hintText}';

    return InputDecoration(
      errorText: widget.errorText,
      hintText: hint,
      hintStyle: CustomStyle.bodyMedium.copyWith(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: _buildPrefixIcon(),
      suffixIcon: widget.isPasswordField
          ? _buildPasswordToggle()
          : widget.suffixIcon,
      fillColor: widget.fillColor ?? Theme.of(context).colorScheme.tertiary,
      filled: widget.isFilled,
      isDense: true,
      contentPadding:
          widget.contentPadding ??
          EdgeInsets.symmetric(
            horizontal: Dimensions.horizontalSize * 0.6,
            vertical: Dimensions.verticalSize * 0.5,
          ),
      border: _border(BorderType.enabled),
      enabledBorder: _border(BorderType.enabled),
      focusedBorder: _border(BorderType.focused),
      disabledBorder: _border(BorderType.disabled),
      errorBorder: _border(BorderType.error),
      focusedErrorBorder: _border(BorderType.focusedError),
    );
  }

  Widget? _buildPrefixIcon() {
    if (widget.prefixIcon != null) return widget.prefixIcon;
    if (widget.prefixIconPath!.isEmpty) return null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageWidget(
            path: widget.prefixIconPath!,
            color: _focusNode.hasFocus || widget.controller.text.isNotEmpty
                ? CustomColor.typography
                : Get.isDarkMode
                ? Colors.white
                : CustomColor.disableColor,
          ),
          if (widget.phoneCode.isNotEmpty) ...[
            SizedBox(width: Dimensions.horizontalSize * 0.3),
            Text(
              widget.phoneCode,
              style: TextStyle(
                fontSize: Dimensions.headlineSmall,
                fontWeight: FontWeight.w500,
                color: _focusNode.hasFocus
                    ? CustomColor.primary
                    : CustomColor.typography.withOpacity(0.2),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.horizontalSize * 0.3),
              height: Dimensions.heightSize * 1.5,
              width: 1,
              color: _focusNode.hasFocus
                  ? CustomColor.primary
                  : CustomColor.typography.withOpacity(0.2),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPasswordToggle() {
    return IconButton(
      icon: Icon(
        _obscureText
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        size: Dimensions.iconSizeDefault,
        color: _focusNode.hasFocus
            ? CustomColor.secondary
            : Get.isDarkMode
            ? CustomColor.secondary
            : CustomColor.disableColor,
      ),
      onPressed: () => setState(() => _obscureText = !_obscureText),
    );
  }

  InputBorder _border(BorderType type) {
    if (!widget.showBorder) return InputBorder.none;

    final color = switch (type) {
      BorderType.enabled => CustomColor.secondary,
      BorderType.focused => CustomColor.primary,
      BorderType.disabled => Colors.transparent,
      BorderType.error => Colors.red,
      BorderType.focusedError => Colors.red,
    };

    final side = BorderSide(width: widget.borderWidth, color: color);

    return switch (widget.borderShape) {
      BorderShapeStyle.outline => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          widget.radius ?? Dimensions.radius * 0.5,
        ),
        borderSide: side,
      ),
      BorderShapeStyle.underline => UnderlineInputBorder(
        borderRadius: BorderRadius.circular(
          widget.radius ?? Dimensions.radius * 0.5,
        ),
        borderSide: side,
      ),
      BorderShapeStyle.none => InputBorder.none,
    };
  }

  void _handleFocus() {
    if (!widget.readOnly) {
      setState(() {
        _focusNode.unfocus();
        _focusNode.requestFocus();
      });
    }
  }

  String? Function(String?) _defaultValidator() {
    if (!widget.useDefaultValidation) return (_) => null;
    return (value) =>
        (value == null || value.isEmpty) ? Strings.pleaseFillOutTheField : null;
  }
}
