import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../grambix/screen/grambix_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../library/screen/library_screen.dart';
import '../../profile/screen/profile_screen.dart';

class NavigationController extends GetxController {
    RxInt selectedIndex = 0.obs;

    List<Widget> bodyPages = [
      HomeScreen(),
      GrambixScreen(),
      LibraryScreen(),
      ProfileScreen(),
    ];

    void changePage(int index) {
      selectedIndex.value = index;
    }

    void goToHome() {
      changePage(0);
    }

    void goToProfile() {
      changePage(3);
    }
}
