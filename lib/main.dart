import 'package:grambix/routes/routes.dart';
import 'package:grambix/views/navigations/grambix/screen/grambix_screen.dart';
import 'package:grambix/views/navigations/home/screen/home_screen.dart';
import 'package:grambix/views/navigations/navigation/screen/navigation_screen.dart';
import 'package:grambix/views/navigations/profile/screen/profile_screen.dart';
import 'package:grambix/views/splash/controller/splash_controller.dart';
import 'package:grambix/views/subscription_with_revenuecat/controller/revenue_cat_services.dart';
import 'core/helpers/network_controller.dart';
import 'core/utils/basic_import.dart';
import 'initial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkController());
  Get.put(RevenueCatService());
  await Initial.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    print('WIDTH: ${size.width}, HEIGHT: ${size.height}');
    return ScreenUtilInit(
      designSize: const Size(411, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GetMaterialApp(
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
      ),
    );
  }
}

//dart run build_runner build
