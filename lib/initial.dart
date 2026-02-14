import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grambix/views/subscription_with_revenuecat/controller/revenue_cat_services.dart';

import 'core/helpers/network_controller.dart';
import 'core/utils/sharepreference_helper.dart';

class Initial {
  static Future<void> init() async {
    // Initialize persistent services immediately
    Get.put(NetworkController(), permanent: true);
    await GetStorage.init();
    SharedPreferenceHelper.init();
    await ScreenUtil.ensureScreenSize();

    // Set app orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Initialize RevenueCat in the background
    _initRevenueCat();
  }

  static void _initRevenueCat() {
    // Lazy initialization to avoid blocking UI
    Future.delayed(Duration.zero, () async {
      try {
        final revenueService = Get.put(RevenueCatService(), permanent: true);
        await revenueService.init(); // Make sure this does not block
        print("RevenueCatService initialized successfully");
      } catch (e) {
        print("RevenueCatService failed: $e");
      }
    });
  }
}
