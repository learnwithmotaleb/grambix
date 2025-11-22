part of '../screen/home_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.findScreen),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.secondary.withAlpha(95),
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.6),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: null,
              icon: SvgPicture.asset(
                Assets.icons.search,
                height: Dimensions.heightSize * 1.8,
              ),
            ),
            TextWidget(Strings.search, color: CustomColor.secondaryTextColor),
          ],
        ),
      ),
    );
  }
}
