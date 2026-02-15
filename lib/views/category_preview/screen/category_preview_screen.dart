import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/res/assets.dart' hide Icons;
import 'package:grambix/widgets/auth_app_bar.dart';
import 'package:grambix/widgets/custom_card_widget.dart';
import 'package:grambix/widgets/empty_data_widget.dart';
import 'package:grambix/widgets/loading_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/languages/strings.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../routes/routes.dart';
import '../../../widgets/text_widget.dart';
import '../controller/category_preview_controller.dart';
part 'category_preview_screen_mobile.dart';

class CategoryPreviewScreen extends GetView<CategoryPreviewController> {
  const CategoryPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: CategoryPreviewScreenMobile());
  }
}
