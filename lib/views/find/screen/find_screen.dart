import 'package:flutter/material.dart' hide Icons;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/widgets/auth_app_bar.dart';
import 'package:grambix/widgets/empty_data_widget.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../../../res/assets.dart' hide Icons;
import '../../../widgets/primary_input_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controller/find_controller.dart';

part 'find_screen_mobile.dart';
part '../widget/serach_box_widget.dart';
part '../widget/serch_items.dart';

class FindScreen extends GetView<FindController> {
  const FindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: FindScreenMobile());
  }
}
