part of 'sp_screen.dart';

class SpScreenMobile extends GetView<SpController> {
  SpScreenMobile({super.key});

  final RevenueCatService _revenueCatService = RevenueCatService();

  // ================================
  // Confirm dialog
  // ================================
  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Payment"),
        content: const Text("Do you want to continue with the payment?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _startPayment(context);
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  // ================================
  // Payment
  // ================================
  Future<void> _startPayment(BuildContext context) async {
    _revenueCatService.isLoading.value = true;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Processing payment…")),
    );

    try {
      final Map<String, dynamic> result =
      await _revenueCatService.purchaseProductDetailed(SubscriptionType.monthly);

      final bool success = result['success'] ?? false;
      final bool cancelled = result['cancelled'] ?? false;
      final String? error = result['error'];

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Payment Successful! Premium Activated."),
          ),
        );
      } else if (cancelled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment cancelled by user.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? "Payment failed.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment error: $e")),
      );
    } finally {
      _revenueCatService.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
            () => PrimaryButtonWidget(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalSize,
            vertical: Dimensions.verticalSize * 2,
          ),
          title: _revenueCatService.isLoading.value
              ? 'Processing…'
              : 'Confirm to Pay',
              onPressed: () {
                if (!_revenueCatService.isLoading.value) {
                  _showConfirmDialog(context);
                }
              },
        ),
      ),

      appBar: CommonAppBar(title: "Payment"),
      body: SafeArea(
        child: Obx(() {
          final isLoading = _revenueCatService.isLoading.value;
          final offerings = _revenueCatService.offerings.value;
          final price = _revenueCatService
              .getProductPrice(RevenueCatService.monthlySubscription);

          return ListView(
            padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
            children: [
              Space.height.v20,
              TextWidget(
                'Payment Details',
                color: CustomColor.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.titleLarge,
              ),
              Space.height.v20,

              // Loading / Error / Ready
              if (isLoading)
                Column(
                  children: [
                    const CircularProgressIndicator(),
                    Space.height.v10,
                    TextWidget("Loading products...", color: Colors.grey),
                  ],
                )
              else if (offerings?.current == null)
                Column(
                  children: [
                    const Icon(Icons.error, color: Colors.orange),
                    Space.height.v10,
                    TextWidget("Products not available", color: Colors.orange),
                  ],
                ),

              Space.height.v20,

              // Subscription Plan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget('Subscription Plan',
                      fontSize: Dimensions.titleSmall, color: Colors.grey),
                  TextWidget('Monthly',
                      color: Colors.grey, fontSize: Dimensions.titleSmall),
                ],
              ),
              Space.height.v10,

              // Fee
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget('Subscription Fee',
                      fontSize: Dimensions.titleSmall, color: Colors.grey),
                  TextWidget(
                    price ?? '\$8.99',
                    color: CustomColor.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.titleSmall,
                  ),
                ],
              ),
              Space.height.v10,

              // Extra Fee
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget('Additional Fee',
                      fontSize: Dimensions.titleSmall, color: Colors.grey),
                  TextWidget('00.00',
                      color: Colors.grey, fontSize: Dimensions.titleSmall),
                ],
              ),
              Space.height.v10,

              // Total Fee
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget('Total Fee',
                      fontSize: Dimensions.titleSmall,
                      color: CustomColor.primary,
                      fontWeight: FontWeight.bold),
                  TextWidget(
                    price ?? '\$8.99',
                    color: CustomColor.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.titleSmall,
                  ),
                ],
              ),
              Space.height.v20,

              // Subscription Benefits
              TextWidget(
                'Subscription Benefits',
                fontSize: Dimensions.titleSmall,
                fontWeight: FontWeight.bold,
              ),
              Space.height.v10,
              const BulletPoint(text: 'Ad-free experience'),
              const BulletPoint(text: 'Unlock all premium features'),
              const BulletPoint(text: 'Exclusive monthly content'),
              const BulletPoint(text: 'Priority customer support'),
              const BulletPoint(text: 'Cloud backup for notes'),
              Space.height.v20,

              // Premium Active Message
              if (_revenueCatService.isPremium.value)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified, color: Colors.green),
                      Space.width.v10,
                      TextWidget(
                        'Premium Active',
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

// Bullet Point Widget
class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 16)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
