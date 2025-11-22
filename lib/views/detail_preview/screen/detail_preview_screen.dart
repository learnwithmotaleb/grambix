import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/core/themes/token.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/views/detail_preview/widget/download_button.dart';
import 'package:grambix/views/navigations/home/controller/home_controller.dart';
import 'package:grambix/views/navigations/library/controller/library_controller.dart';
import 'package:grambix/views/reading/controller/reading_controller.dart';
import 'package:grambix/widgets/custom_card_widget.dart';
import 'package:grambix/widgets/loading_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../res/assets.dart' hide Icons;
import '../../../routes/routes.dart';
import '../controller/detail_preview_controller.dart';
import '../widget/expand_text_widget.dart';

part 'detail_preview_screen_mobile.dart';

part '../widget/top_text_heading.dart';
part '../widget/select_button.dart';
part '../widget/shape_container.dart';
part '../widget/img_preview.dart';

class DetailPreviewScreen extends GetView<DetailPreviewController> {
  const DetailPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: DetailPreviewScreenMobile());
  }
}
