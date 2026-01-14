import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/revenue_cat_services.dart';

class SpScreenMobile extends StatelessWidget {
  SpScreenMobile({super.key});

  final RevenueCatService _rev = RevenueCatService();

  /// -----------------------
  /// Show BottomSheet for Confirmation
  /// -----------------------
  void _showConfirmBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // allow full height if needed
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              "Confirm Payment",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Description
            const Text(
              "Do you want to continue with the payment to unlock premium features?",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),

            // Buttons
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[800],
                      side: BorderSide(color: Colors.grey[300]!),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                // Confirm / Continue Button
                Expanded(
                  child: Obx(() => GestureDetector(
                    onTap: !_rev.isLoading.value
                        ? () {
                      Navigator.pop(context);
                      _rev.purchaseMonthly();
                    }
                        : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: !_rev.isLoading.value
                            ? const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF42A5F5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : LinearGradient(
                          colors: [Colors.grey[400]!, Colors.grey[400]!],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: !_rev.isLoading.value
                            ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: const Offset(0, 5),
                            blurRadius: 10,
                          )
                        ]
                            : [],
                      ),
                      child: Center(
                        child: _rev.isLoading.value
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                            : const Text(
                          "Confirm to Pay",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  )),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }


  /// -----------------------
  /// Build Paywall Screen
  /// -----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      bottomNavigationBar: Obx(
            () => Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: !_rev.isLoading.value
                ? () => _showConfirmBottomSheet(context)
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 55,
              decoration: BoxDecoration(
                gradient: !_rev.isLoading.value
                    ? const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : const LinearGradient(
                  colors: [Colors.grey, Colors.grey],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: !_rev.isLoading.value
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                  )
                ]
                    : [],
              ),
              child: Center(
                child: _rev.isLoading.value
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text(
                  "Confirm to Pay",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Obx(() {
          final isLoading = _rev.isLoading.value;
          final price =
          _rev.getProductPrice(RevenueCatService.monthlySubscription);

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
                      children: const [
                        Text('Subscription Plan', style: TextStyle(color: Colors.grey)),
                        Text('Monthly', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subscription Fee', style: TextStyle(color: Colors.grey)),
                        Text(
                          price ?? '\$12.99',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
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
                    if (_rev.isPremium.value)
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

/// -----------------------
/// Bullet Point Widget
/// -----------------------
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
