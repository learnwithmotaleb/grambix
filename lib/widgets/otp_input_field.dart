import 'package:pin_code_fields/pin_code_fields.dart';
import '../core/utils/basic_import.dart';

class OtpInputField extends StatelessWidget {
  const OtpInputField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        selectedFillColor: CustomColor.secondary,
        inactiveFillColor: CustomColor.background,
        inactiveColor: CustomColor.secondary,
        selectedColor: CustomColor.primary,
        activeColor: CustomColor.primary,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
        fieldHeight: 40.h,
        fieldWidth: 40.w,
        activeFillColor: CustomColor.secondary,
      ),
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: controller,
      onCompleted: (v) {
        print("Completed");
      },

      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        return true;
      },
      appContext: context,
    );
  }
}
