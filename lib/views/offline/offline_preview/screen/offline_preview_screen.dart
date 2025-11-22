import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import '../../../../core/api/end_point/api_end_points.dart';
import '../../../../core/languages/strings.dart';
import '../../../../core/themes/token.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/layout.dart';
import '../../../../core/utils/space.dart';
import '../../../../res/assets.dart' hide Icons;
import '../../../../routes/routes.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/text_widget.dart';
import '../../../detail_preview/screen/detail_preview_screen.dart';
import '../../../detail_preview/widget/expand_text_widget.dart';
import '../controller/offline_preview_controller.dart';
part 'offline_preview_screen_mobile.dart';
part '../widget/customContainer.dart';

class OfflinePreviewScreen extends GetView<OfflinePreviewController> {
  const OfflinePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: OfflinePreviewScreenMobile());
  }
}
