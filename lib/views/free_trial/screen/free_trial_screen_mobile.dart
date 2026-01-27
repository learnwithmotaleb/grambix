part of 'free_trial_screen.dart';

class FreeTrialScreenMobile extends GetView<FreeTrialController> {
  const FreeTrialScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Subscription"),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsetsGeometry.symmetric(vertical: Dimensions.verticalSize),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalSize,
            vertical: Dimensions.verticalSize * 0.35,
          ),
          decoration: BoxDecoration(
            color: CustomColor.whiteColor.withAlpha(33),
            border: Border.symmetric(
              horizontal: BorderSide(color: CustomColor.whiteColor),
            ),
          ),
          child: Column(
            crossAxisAlignment: crossStart,
            mainAxisSize: mainMin,
            children: [
              TextWidget(
                'Payment Option',
                fontWeight: FontWeight.bold,
                color: CustomColor.whiteColor,
              ),
              Space.height.v10,
              Image.asset(Assets.icons.pay),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: mainCenter,
          children: [
            Container(
              margin: EdgeInsetsGeometry.symmetric(
                horizontal: Dimensions.defaultHorizontalSize,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: CustomColor.whiteColor),
                borderRadius: BorderRadius.circular(Dimensions.radius),
              ),
              padding: EdgeInsets.all(Dimensions.paddingSize),
              child: Column(
                children: [
                  TextWidget(
                    'Start Your Free 30-Day Trial!',
                    color: CustomColor.whiteColor,
                  ),
                  TextWidget(
                    padding: EdgeInsetsGeometry.only(
                      bottom: Dimensions.verticalSize * 2,
                      top: Dimensions.verticalSize,
                    ),
                    'Explore thousands of books & audiobooks — free for 30 days, no credit card required!”',
                    color: CustomColor.whiteColor,
                    fontSize: Dimensions.titleSmall,
                  ),
                  TextWidget(
                    padding: EdgeInsetsGeometry.only(
                      bottom: Dimensions.verticalSize,
                      top: Dimensions.verticalSize,
                    ),

                    'Only \$12.99/month after trial. Cancel anytime.',
                    fontSize: Dimensions.titleSmall,

                    color: CustomColor.whiteColor,
                  ),

                  PrimaryButtonWidget(
                    title: 'Start Free Trial',
                    onPressed: () => Get.toNamed(Routes.spScreen),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
