import '../../../core/utils/basic_import.dart';
import '../controller/revenue_cat_services.dart';

class SpScreenMobile extends StatefulWidget {
  const SpScreenMobile({super.key});

  @override
  State<SpScreenMobile> createState() => _SpScreenMobileState();
}

class _SpScreenMobileState extends State<SpScreenMobile> {
  final RevenueCatService _rev = Get.find<RevenueCatService>();

  @override
  void initState() {
    super.initState();
    _rev.refreshStatus();
  }

  void _showConfirmBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50, height: 5,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(height: 20),
            const Text("Confirm Payment", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Unlock instant access to all premium features.", textAlign: TextAlign.center),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Obx(() => ElevatedButton(
                    onPressed: _rev.isLoading.value ? null : () async {
                      Navigator.pop(context);
                      bool success = await _rev.purchaseMonthly();
                      if (success) {
                        Get.snackbar("Success", "Welcome to Premium!", backgroundColor: Colors.green, colorText: Colors.white);
                        Get.back();
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF)),
                    child: const Text("Confirm", style: TextStyle(color: Colors.white)),
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grambix Premium"),
        actions: [
          TextButton(
            onPressed: () => _rev.restorePurchases(),
            child: const Text("Restore", style: TextStyle(color: Color(0xFF6C63FF))),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomPayButton(context),
      body: SafeArea(
        child: Obx(() {
          // 1. Check if we are still loading initial data
          if (_rev.isLoading.value && _rev.offerings.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final price = _rev.getProductPrice();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader(),
              const SizedBox(height: 24),

              // 2. Visual warning if configuration is wrong
              if (price == null && !_rev.isLoading.value)
                _buildConfigErrorNotice(),

              _buildPriceCard(price),
              const SizedBox(height: 24),
              _buildBenefitsList(),
              const SizedBox(height: 32),
              _buildLegalFooter(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildConfigErrorNotice() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      color: Colors.red.withOpacity(0.1),
      child: const Text(
        "Notice: Products not found. Ensure your RevenueCat Offering ID is set to 'monthly' and products are attached.",
        style: TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Icon(Icons.stars_rounded, size: 80, color: Color(0xFF6C63FF)),
        const Text("Upgrade to Pro", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPriceCard(String? price) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF).withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Monthly Plan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Billed monthly. Cancel anytime.", style: TextStyle(color: Colors.grey)),
            ],
          ),
          Text(
            price ?? 'Fetching...', // Changes '---' to 'Fetching' for better UX
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF6C63FF)),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsList() {
    return const Column(
      children: [
        BulletPoint(text: 'Ad-free experience'),
        BulletPoint(text: 'Unlock all premium features'),
        BulletPoint(text: 'Priority customer support'),
      ],
    );
  }

  Widget _buildLegalFooter() {
    return const Center(
      child: Text(
        "Auto-renews unless canceled 24h before end of period.",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  Widget _buildBottomPayButton(BuildContext context) {
    return Obx(() {
      final canPay = !_rev.isPremium.value && _rev.getProductPrice() != null;

      return Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: canPay ? () => _showConfirmBottomSheet(context) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: _rev.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
            _rev.isPremium.value ? "PRO UNLOCKED" : "CONTINUE TO PAY",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 18),
        const SizedBox(width: 10),
        Text(text),
      ]),
    );
  }
}