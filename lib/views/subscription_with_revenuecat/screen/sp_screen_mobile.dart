import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../core/utils/basic_import.dart';
import '../controller/revenue_cat_services.dart';

class SpScreenMobile extends StatefulWidget {
  const SpScreenMobile({super.key});

  @override
  State<SpScreenMobile> createState() => _SpScreenMobileState();
}

class _SpScreenMobileState extends State<SpScreenMobile> {
  final RevenueCatService _rev = Get.find<RevenueCatService>();
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    await _rev.refreshStatus();
    setState(() {
      _hasInitialized = true;
    });
  }

  void _showConfirmBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: CustomColor.primary,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Confirm Payment",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Unlock instant access to all premium features.",
              textAlign: TextAlign.center,
            ),
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
                  child: Obx(
                        () => ElevatedButton(
                      onPressed: _rev.isLoading.value
                          ? null
                          : () async {
                        Navigator.pop(context);
                        bool success = await _rev.purchaseMonthly();
                        if (success) {
                          Get.snackbar(
                            "Success",
                            "Welcome to Premium!",
                            backgroundColor: CustomColor.primary,
                            colorText: Colors.white,
                          );
                          Get.back();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.primary,
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDebugInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Debug Information",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildDebugItem("Is Premium:", _rev.isPremium.value.toString()),
            _buildDebugItem("Is Loading:", _rev.isLoading.value.toString()),
            _buildDebugItem(
              "Current Offering:",
              _rev.offerings.value?.current?.identifier ?? "None",
            ),
            _buildDebugItem(
              "Packages Available:",
              (_rev.offerings.value?.current?.availablePackages.length ?? 0)
                  .toString(),
            ),
            _buildDebugItem(
              "Product Price:",
              _rev.getProductPrice() ?? "Not Available",
            ),
            _buildDebugItem(
              "Platform:",
              Platform.isIOS ? "iOS" : "Android",
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _rev.refreshStatus();
                Get.back();
                Get.snackbar("Refreshed", "Status updated");
              },
              child: const Text("Refresh Status",style: TextStyle(color: CustomColor.whiteColor),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebugItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: value == "None" || value == "Not Available"
                  ? Colors.red
                  : Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigErrorNotice() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "⚠️ Configuration Issue",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Products not found. This could be due to:",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBulletPoint("Google Play subscription is inactive"),
                    _buildBulletPoint(
                        "RevenueCat product not published or linked"),
                    _buildBulletPoint("No entitlement configured"),
                    _buildBulletPoint("Offering not set as 'current'"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showDebugInfo(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red.withOpacity(0.5)),
                      ),
                      child:  Text(
                        "Show Debug Info",
                        style: TextStyle(fontSize: 12, color: CustomColor.primary),

                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _rev.refreshStatus(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:CustomColor.primary,
                      ),
                      child: const Text(
                        "Retry",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(color: Colors.red)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.red, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.backgroundDark,
        leading: GestureDetector(
          onTap: (){

            Get.back();
          },
            child: Icon(Icons.arrow_back_ios,color: CustomColor.whiteColor,)) ,
        title:  Text("Premium",style: TextStyle(color: CustomColor.whiteColor,fontWeight: FontWeight.bold),),
        actions: [
          // Debug button - remove in production
          if (kDebugMode)
          TextButton(
            onPressed: () => _rev.restorePurchases(),
            child: Text(
              "Restore",
                style: TextStyle(color: CustomColor.whiteColor,fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          // Show loading initially
          if (_rev.isLoading.value && !_hasInitialized) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: CustomColor.primary),
                  const SizedBox(height: 20),
                  Text(
                    "Loading store...",
                    style: TextStyle(color: CustomColor.primary),
                  ),
                ],
              ),
            );
          }

          final price = _rev.getProductPrice();
          final hasProducts = price != null;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),

                    // Configuration error notice
                    if (!hasProducts && !_rev.isLoading.value)
                      _buildConfigErrorNotice(),

                    // Price card
                    if (hasProducts || _rev.isLoading.value)
                      _buildPriceCard(price),

                    if (_rev.isLoading.value) ...[
                      const SizedBox(height: 16),
                      Center(
                        child: CircularProgressIndicator(
                          color: CustomColor.primary,
                        ),
                      ),
                    ],

                    if (hasProducts) ...[
                      const SizedBox(height: 24),
                      _buildBenefitsList(),
                      const SizedBox(height: 32),
                      _buildLegalFooter(),
                    ],
                  ],
                ),
              ),

              // Bottom button
              if (!_rev.isPremium.value)
                _buildBottomPayButton(context, hasProducts),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
          _rev.isPremium.value ? Icons.stars_rounded : Icons.upgrade_rounded,
          size: 80,
          color: CustomColor.primary,
        ),
        const SizedBox(height: 10),
        Text(
          _rev.isPremium.value ? "Pro Member" : "Upgrade to Pro",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: CustomColor.primary,
          ),
        ),
        if (_rev.isPremium.value)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              "Thank you for your subscription!",
              style: TextStyle(
                fontSize: 14,
                color: CustomColor.primary.withOpacity(0.8),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPriceCard(String? price) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: CustomColor.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CustomColor.primary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Monthly Plan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: CustomColor.primary,
                ),
              ),
              Text(
                "Billed monthly. Cancel anytime.",
                style: TextStyle(color: CustomColor.primary.withOpacity(0.8)),
              ),
            ],
          ),
          Text(
            price ?? 'Loading...',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: CustomColor.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsList() {
    return Column(
      children: [
        _buildBenefitItem(Icons.block, "Ad-free experience"),
        _buildBenefitItem(Icons.lock_open, "Unlock all premium features"),
        _buildBenefitItem(Icons.support_agent, "Priority customer support"),
        _buildBenefitItem(Icons.update, "Monthly content updates"),
      ],
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: CustomColor.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: CustomColor.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: CustomColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalFooter() {
    return Column(
      children: [
        Text(
          "Auto-renews unless canceled 24h before end of period.",
          style: TextStyle(
            fontSize: 12,
            color: CustomColor.primary.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "Payment will be charged to your Google Play/App Store account.",
          style: TextStyle(
            fontSize: 10,
            color: CustomColor.primary.withOpacity(0.5),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBottomPayButton(BuildContext context, bool hasProducts) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: !hasProducts || _rev.isPremium.value || _rev.isLoading.value
              ? null
              : () => _showConfirmBottomSheet(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor.primary,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
          ),
          child: _rev.isLoading.value
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
            _rev.isPremium.value
                ? "PRO UNLOCKED ✓"
                : hasProducts
                ? "CONTINUE TO PAY - ${_rev.getProductPrice()}/month"
                : "CONFIGURE STORE FIRST",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: CustomColor.primary),
          ),
        ],
      ),
    );
  }
}