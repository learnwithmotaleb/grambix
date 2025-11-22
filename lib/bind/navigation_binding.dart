import 'package:get/get.dart';
import '../views/navigations/grambix/controller/grambix_controller.dart';
import '../views/navigations/home/controller/home_controller.dart';
import '../views/navigations/library/controller/library_controller.dart';
import '../views/navigations/navigation/controller/navigation_controller.dart';
import '../views/navigations/profile/controller/profile_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<GrambixController>(() => GrambixController());
    Get.lazyPut<LibraryController>(() => LibraryController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
