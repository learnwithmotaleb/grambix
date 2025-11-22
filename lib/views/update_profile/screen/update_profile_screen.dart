import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/views/navigations/profile/controller/profile_controller.dart';
import 'package:grambix/widgets/auth_app_bar.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/languages/strings.dart';
import '../../../core/themes/token.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/primary_input_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controller/update_profile_controller.dart';
part 'update_profile_screen_mobile.dart';

class UpdateProfileScreen extends GetView<UpdateProfileController> {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: UpdateProfileScreenMobile());
  }
}
