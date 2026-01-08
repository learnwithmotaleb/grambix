// ================================
// Example Paywall Screen
// ================================
import '../../../core/utils/basic_import.dart';
import '../controller/revenue_cat_services.dart';

class SpScreenMobile extends StatelessWidget {
  SpScreenMobile({super.key});

  final RevenueCatService _revenueCatService = RevenueCatService();

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
             // _revenueCatService.showPaywall(); // Show native RevenueCat paywall
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      bottomNavigationBar: Obx(
            () => Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              if (!_revenueCatService.isLoading.value) {
                _showConfirmDialog(context);
              }
            },
            child: Text(
              _revenueCatService.isLoading.value
                  ? 'Loading…'
                  : 'Confirm to Pay',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          final isLoading = _revenueCatService.isLoading.value;
          final price = _revenueCatService
              .getProductPrice(RevenueCatService.monthlySubscription);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 20),
              const Text(
                'Payment Details',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 20),
              if (isLoading)
                Column(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("Loading products...", style: TextStyle(color: Colors.grey)),
                  ],
                )
              else
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subscription Plan', style: TextStyle(color: Colors.grey)),
                        const Text('Monthly', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subscription Fee', style: TextStyle(color: Colors.grey)),
                        Text(price ?? '\$12.99',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.blue)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Subscription Benefits',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const BulletPoint(text: 'Ad-free experience'),
                    const BulletPoint(text: 'Unlock all premium features'),
                    const BulletPoint(text: 'Exclusive monthly content'),
                    const BulletPoint(text: 'Priority customer support'),
                    const BulletPoint(text: 'Cloud backup for notes'),
                    const SizedBox(height: 20),
                    if (_revenueCatService.isPremium.value)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.verified, color: Colors.green),
                            SizedBox(width: 10),
                            Text('Premium Active',
                                style: TextStyle(
                                    color: Colors.green, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                  ],
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