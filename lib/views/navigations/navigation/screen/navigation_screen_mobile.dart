part of 'navigation_screen.dart';

class NavigationScreenMobile extends GetView<NavigationController> {
  const NavigationScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        if (controller.selectedIndex.value != 0) {
          controller.selectedIndex.value = 0;
        } else {
          final shouldExit = await Get.dialog<bool>(
            _ExitConfirmationDialog(),
            barrierDismissible: false,
          );

          if (shouldExit == true) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        extendBody: true,
        body: Obx(() => controller.bodyPages[controller.selectedIndex.value]),
        bottomNavigationBar: SafeArea(child: NavigationBarWidget()),
      ),
    );
  }
}

class _ExitConfirmationDialog extends StatelessWidget {
  const _ExitConfirmationDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        decoration: BoxDecoration(
          color:
          CustomColor.grey850,

          borderRadius: BorderRadius.circular(Dimensions.radius * 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.paddingSize * 0.6),
              decoration: BoxDecoration(
                color: CustomColor.rejected.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.exit_to_app_rounded,
                size: Dimensions.iconSizeLarge * 2.5,
                color: CustomColor.rejected,
              ),
            ),
            Space.height.v20,
            TextWidget(
              'Exit App?',
              fontSize: Dimensions.headlineSmall * 0.9,
              fontWeight: FontWeight.w500,
              color: CustomColor.whiteColor,
              textAlign: TextAlign.center,
            ),
            Space.height.v10,
            TextWidget(
              'Are you sure you want to exit the application?',
              fontSize: Dimensions.bodyMedium,
              fontWeight: FontWeight.w400,
              color: CustomColor.secondaryTextColor,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            Space.height.v30,
            Row(
              children: [
                Expanded(
                  child: PrimaryButtonWidget(
                    title: 'Cancel',
                    onPressed: () => Get.back(result: false),
                    buttonColor: CustomColor.grey400.withOpacity(0.3),
                    buttonTextColor:  CustomColor.grey400,
                    borderColor: Colors.transparent,
                    fontWeight: FontWeight.w500,
                    height: Dimensions.buttonHeight * 0.85,
                  ),
                ),
                Space.width.v10,
                Expanded(
                  child: PrimaryButtonWidget(
                    title: 'Exit',
                    onPressed: () => Get.back(result: true),
                    buttonColor: CustomColor.rejected,
                    buttonTextColor: CustomColor.whiteColor,

                    fontWeight: FontWeight.w500,
                    borderColor: CustomColor.rejected,
                    height: Dimensions.buttonHeight * 0.85,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
