import 'package:grambix/routes/routes.dart';
import 'package:grambix/views/splash/controller/splash_controller.dart';
import 'package:grambix/views/subscription_with_revenuecat/controller/revenue_cat_services.dart';
import 'core/helpers/network_controller.dart';
import 'core/utils/basic_import.dart';
import 'initial.dart';

void main()  {
  // 1. Ensure Flutter bindings are ready
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Perform general app initialization (Firebase, etc.)
   Initial.init();

  // 3. Initialize RevenueCat BEFORE the app runs
  // This ensures that subscription status is ready immediately
  Get.put(RevenueCatService(), permanent: true);
  Get.put(NetworkController(), permanent: true);
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