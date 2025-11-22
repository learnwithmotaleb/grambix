part of '../screen/library_screen.dart';

class EmtyLibraryWidget extends StatelessWidget {
  const EmtyLibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      crossAxisAlignment: crossCenter,
      children: [
        Padding(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          child: Column(
            mainAxisAlignment: mainCenter,
            children: [
              SvgPicture.asset(Assets.logo.emtyLibrary),
              Space.height.v15,
              TextWidget(
                'Your library is empty.',
                color: CustomColor.whiteColor,
                fontWeight: FontWeight.w600,
              ),
              Space.height.v15,
              TextWidget(
                textAlign: TextAlign.center,
                'Start saving or downloading your favorite books to build your collection',
                color: CustomColor.secondary,
                fontSize: Dimensions.titleSmall * 0.9,
              ),
              Space.height.v40,
              PrimaryButtonWidget(
                title: 'Browse Now',
                onPressed: () {
                  Get.find<LibraryController>().loadDownloads();
                  Get.find<NavigationController>().goToHome();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
