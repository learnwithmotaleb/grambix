part of 'subcription_screen.dart';

class SubcriptionScreenMobile extends GetView<SubcriptionsController> {
  const SubcriptionScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Strings.subscription),

      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Container(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: Dimensions.verticalSize,
                horizontal: Dimensions.defaultHorizontalSize,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: CustomColor.whiteColor),
                borderRadius: BorderRadius.circular(Dimensions.radius),
              ),
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  TextWidget(
                    'Free Trial',
                    color: CustomColor.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  Space.height.v20,
                  Row(
                    mainAxisAlignment: mainSpaceBet,

                    children: [
                      TextWidget('Purchase Date :', color: Colors.white),
                      TextWidget('10th July,2025', color: Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      TextWidget('Expire Date :', color: Colors.white),
                      TextWidget('10th July,2025', color: Colors.white),
                    ],
                  ),

                  Space.height.v40,
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButtonWidget(
                          title: 'Cancel',
                          onPressed: () {},
                        ),
                      ),
                      Space.width.v10,
                      Expanded(
                        child: PrimaryButtonWidget(
                          title: 'Upgrade Now',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            TextWidget(
              "Available Plan",
              color: CustomColor.whiteColor,
              fontWeight: FontWeight.bold,
              padding: EdgeInsetsGeometry.symmetric(
                vertical: Dimensions.verticalSize * 0.5,
              ),
            ),
            Container(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: Dimensions.verticalSize,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: CustomColor.whiteColor),
                borderRadius: BorderRadius.circular(Dimensions.radius),
              ),
              child: Column(
                children: [
                  TextWidget('Premium Plan', color: Colors.white),
                  Space.height.v10,
                  TextWidget(
                    '\$120 month',
                    fontSize: Dimensions.titleSmall,
                    color: Colors.white,
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
