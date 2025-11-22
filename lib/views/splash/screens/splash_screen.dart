import 'package:grambix/core/utils/basic_import.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/views/auth/login/widget/app_logo_widget.dart';

import '../controller/splash_controller.dart';

part 'splash_screen_mobile.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: SplashScreenMobile());
  }
}
