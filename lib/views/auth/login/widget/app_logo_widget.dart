import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/basic_import.dart';
import '../../../../res/assets.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.logo.appLogo,
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
