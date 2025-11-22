import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/routes/routes.dart';
import 'package:grambix/views/navigations/home/screen/home_screen.dart';
import '../../../../core/utils/basic_import.dart';
import '../../../../core/utils/layout.dart';
import '../../../../core/utils/space.dart';
import '../../../../res/assets.dart' hide Icons;
import '../../../../widgets/custom_card_widget.dart';
import '../../../../widgets/primary_button_widget.dart';
import '../../../../widgets/text_widget.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../controller/library_controller.dart';
part 'library_screen_mobile.dart';
part '../widget/emty_library_widget.dart';
part '../widget/top_selection_bar.dart';
part '../widget/grid_custom_card.dart';
part '../widget/library_card.dart';

class LibraryScreen extends GetView<LibraryController> {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: LibraryScreenMobile());
  }
}
