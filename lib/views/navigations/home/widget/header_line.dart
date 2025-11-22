part of '../screen/home_screen.dart';

class HeaderLine extends StatelessWidget {
  final String header;
  final Function()? onTap;

  const HeaderLine({super.key, required this.header, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.verticalSize * 0.4,
        top: Dimensions.verticalSize * 0.5,
      ),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          TextWidget(
            header,
            color: CustomColor.whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.titleMedium * 1.1,
          ),
          TextWidget(
            onTap: onTap,
            Strings.showAll,
            color: CustomColor.primary,
            fontSize: Dimensions.titleSmall *0.98,
          ),
        ],
      ),
    );
  }
}
