import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/themes/token.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../res/assets.dart' hide Icons;
import '../controller/player_controller.dart';

part 'player_screen_mobile.dart';
part '../widget/bottom_music_bar.dart';
class PlayerScreen extends GetView<PlayerController> {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: PlayerScreenMobile());
  }
}
