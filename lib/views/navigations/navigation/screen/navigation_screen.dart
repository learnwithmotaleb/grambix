import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/layout.dart';
import '../controller/navigation_controller.dart';
import '../widget/navigation_bar_widget.dart';
part 'navigation_screen_mobile.dart';

class NavigationScreen extends GetView<NavigationController> {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: NavigationScreenMobile());
  }
}
