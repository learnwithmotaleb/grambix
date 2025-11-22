part of 'navigation_screen.dart';

class NavigationScreenMobile extends GetView<NavigationController> {
  const NavigationScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(() => controller.bodyPages[controller.selectedIndex.value]),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}
