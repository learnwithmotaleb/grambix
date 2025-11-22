import 'package:flutter_svg/flutter_svg.dart';
import 'package:grambix/core/utils/app_storage.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/res/assets.dart' hide Icons;
import 'package:grambix/routes/routes.dart';
import 'package:grambix/widgets/loading_widget.dart';
import 'package:grambix/widgets/primary_button_widget.dart';
import 'package:grambix/widgets/text_widget.dart';
import '../../../../core/api/end_point/api_end_points.dart';
import '../../../../core/utils/basic_import.dart';
import '../../../auth/login/controller/login_controller.dart';
import '../controller/profile_controller.dart';

part 'profile_screen_mobile.dart';

part '../widget/profile_image_widget.dart';

part '../widget/profile_section_heading.dart';
part '../widget/logout_dialog.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ProfileScreenMobile());
  }
}
