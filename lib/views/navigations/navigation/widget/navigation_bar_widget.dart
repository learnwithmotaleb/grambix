import 'dart:ui';
import '../../../../core/utils/basic_import.dart';
import '../../../../res/assets.dart';
import 'bottom_bar_widget.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        // topLeft: Radius.circular(25),
        // topRight: Radius.circular(25),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0), // 👈 Strong Blur
        child: Container(
          height: Dimensions.heightSize * 6.5,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03), // 👈 Very transparent
            border: Border(
              top: BorderSide(
                color: Colors.white.withOpacity(0.15), // soft glass border
                width: 1.0,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 40,
                spreadRadius: 0,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: BottomBarWidget(
                  path: Assets.icons.home,
                  svgSize: Dimensions.iconSizeDefault * 1.1,
                  label: Strings.home,
                  index: 0,
                ),
              ),
              Expanded(
                child: BottomBarWidget(
                  path: Assets.icons.myGrambix,
                  label: Strings.myGrambix,
                  index: 1,
                ),
              ),
              Expanded(
                child: BottomBarWidget(
                  path: Assets.icons.library,
                  label: Strings.library,
                  index: 2,
                ),
              ),
              Expanded(
                child: BottomBarWidget(
                  path: Assets.icons.profile,
                  label: Strings.profile,
                  index: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
