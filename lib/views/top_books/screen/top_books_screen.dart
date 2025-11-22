import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/res/assets.dart';
import 'package:grambix/views/navigations/home/controller/home_controller.dart';
import 'package:grambix/widgets/auth_app_bar.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../routes/routes.dart';
import '../controller/top_books_controller.dart';

part 'top_books_screen_mobile.dart';

class TopBooksScreen extends GetView<TopBooksController> {
  const TopBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: TopBooksScreenMobile());
  }
}
