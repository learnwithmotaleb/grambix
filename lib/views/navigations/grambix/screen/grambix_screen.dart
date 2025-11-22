import 'package:flutter_svg/flutter_svg.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';

import 'package:grambix/core/utils/basic_import.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/res/assets.dart';
import 'package:grambix/routes/routes.dart';
import 'package:grambix/views/navigations/home/controller/home_controller.dart';
import 'package:grambix/views/navigations/home/screen/home_screen.dart';
import 'package:grambix/views/navigations/library/controller/library_controller.dart';
import 'package:grambix/views/navigations/library/screen/library_screen.dart';
import 'package:grambix/widgets/empty_data_widget.dart';
import 'package:grambix/widgets/loading_widget.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../../widgets/custom_card_widget.dart';
import '../controller/grambix_controller.dart';

part 'grambix_screen_mobile.dart';

part '../widget/grambix_empty.dart';
part '../widget/custom_grambix_card.dart';

class GrambixScreen extends GetView<GrambixController> {
  const GrambixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: GrambixScreenMobile());
  }
}
