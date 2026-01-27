import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import '../../widgets/custom_snackbar.dart';
import '../languages/strings.dart';

class NetworkController extends GetxController {
  RxBool isConnected = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startCheckingInternet();
  }

  void _startCheckingInternet() {
    // Check every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      bool newStatus = await _hasInternet();

      if (newStatus != isConnected.value) {
        isConnected.value = newStatus;

        if (!newStatus) {
          CustomSnackBar.error(Strings.noInternetConnection);
        } else {
          CustomSnackBar.success(
            title: Strings.internetRestored,
            message: Strings.yourInternetConnectionHasBeenRestored,
          );
        }
      }
    });
  }

  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
