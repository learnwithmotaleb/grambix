part of 'payment_screen.dart';

class PaymentScreenMobile extends GetView<PaymentController> {
  const PaymentScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Payment"),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            TextWidget('Enter Card Details'),
            PrimaryInputWidget(
              fillColor: CustomColor.secondary.withAlpha(95),
              isFilled: true,
              label: "Card-holder's Name",
              radius: Dimensions.radius * 0.85,
              controller: TextEditingController(),
              hintText: '',
            ),
            Space.height.betweenInputBox,
            PrimaryInputWidget(
              fillColor: CustomColor.secondary.withAlpha(95),
              isFilled: true,
              label: "Card Number",
              radius: Dimensions.radius * 0.85,
              controller: TextEditingController(),
              hintText: '',
            ),
            Space.height.betweenInputBox,
            Row(
              children: [
                Expanded(
                  child: PrimaryInputWidget(
                    fillColor: CustomColor.secondary.withAlpha(95),
                    isFilled: true,
                    label: "Expire Date",
                    radius: Dimensions.radius * 0.85,
                    controller: TextEditingController(),
                    hintText: '',
                  ),
                ),
                Space.width.v10,
                Expanded(
                  child: PrimaryInputWidget(
                    fillColor: CustomColor.secondary.withAlpha(95),
                    isFilled: true,
                    label: "CVC",
                    radius: Dimensions.radius * 0.85,
                    controller: TextEditingController(),
                    hintText: '',
                  ),
                ),
              ],
            ),
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,
            PrimaryButtonWidget(title: 'Pay', onPressed: () {
              print("payment add now");
              
            }),
          ],
        ),
      ),
    );
  }
}
