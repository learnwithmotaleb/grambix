part of '../screen/grambix_screen.dart';

class GrambixEmpty extends StatelessWidget {
  const GrambixEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          SvgPicture.asset(Assets.logo.emptyGrambix),
          Space.height.v15,

          TextWidget(
            'Nothing here yet — but every great story begins with one tap',
            color: CustomColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
          Space.height.v15,
          TextWidget(
            '📚 Once you begin reading or listening, we’ll show your progress here — hours, streaks, and more!',
            color: CustomColor.secondary,
            fontSize: Dimensions.titleSmall,
          ),
          Space.height.v40,
          PrimaryButtonWidget(
            title: 'Explore Library',
            onPressed: () {
              Get.toNamed(Routes.allCategoryScreen, arguments: 4);
            },
          ),
        ],
      ),
    );
  }
}
