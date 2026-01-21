import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/routes/routes.dart';
import 'package:grambix/views/all_category/widget/app_hader_widget.dart';
import 'package:grambix/widgets/empty_data_widget.dart';
import 'package:grambix/widgets/loading_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../res/assets.dart' hide Icons;
import '../../../widgets/text_widget.dart';
import '../../navigations/home/controller/home_controller.dart';
import '../controller/all_category_controller.dart';

part 'all_category_screen_mobile.dart';

part '../widget/custom_grid_widget.dart';
part '../widget/tab_widgets.dart';

class AllCategoryScreen extends GetView<AllCategoryController> {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: AllCategoryScreenMobile());
  }
}
