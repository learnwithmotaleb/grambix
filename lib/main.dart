import 'package:grambix/routes/routes.dart';
import 'package:grambix/views/splash/controller/splash_controller.dart';
import 'package:grambix/views/subscription_with_revenuecat/controller/revenue_cat_services.dart';
import 'core/helpers/network_controller.dart';
import 'core/utils/basic_import.dart';
import 'initial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initial.init();
  //Configure RevenueCat
  try {
    await RevenueCatService().init();
  } catch (e) {
    debugPrint("RevenueCat init failed: $e");
  }
  runApp(const MyApp());

}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splashScreen,
          title: Strings.appName,
          theme: Themes.light,
          darkTheme: Themes.dark,
          getPages: Routes.list,
          defaultTransition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 300),
          themeMode: ThemeMode.light,
          initialBinding: BindingsBuilder(() {
            Get.lazyPut(() => SplashController());
          }),
          builder: (context, widget) {
            return Directionality(
              textDirection: Get.locale?.languageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: widget!,
            );
          },
        );
      },
    );
  }
}



