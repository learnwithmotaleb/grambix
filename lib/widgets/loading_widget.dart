import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../core/utils/basic_import.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: color ?? CustomColor.primary,
        size: Dimensions.verticalSize * 1.5,
      ),
    );
  }
}
