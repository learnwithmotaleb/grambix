import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/api/services/api_request.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/res/assets.dart' hide Icons;
import 'package:grambix/views/navigations/profile/controller/profile_controller.dart';
import 'package:grambix/widgets/custom_card_widget.dart';
import 'package:grambix/widgets/loading_widget.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utils/basic_import.dart';
import '../../../../routes/routes.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../controller/home_controller.dart';

part 'home_screen_mobile.dart';

part '../widget/top_bar_widget.dart';

part '../widget/home_slider_widget.dart';

part '../widget/search_bar_widget.dart';

part '../widget/tab_item_section.dart';

part '../widget/header_line.dart';

part '../widget/items_card_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: HomeScreenMobile(),
    tablet: HomeScreenMobile(),
    );
  }
}
