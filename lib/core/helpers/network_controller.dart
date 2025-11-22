import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../widgets/custom_snackbar.dart';
import '../languages/strings.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initConnectivityCheck();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _initConnectivityCheck() async {
    var result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    final newStatus = result != ConnectivityResult.none;

    if (isConnected.value != newStatus) {
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
  }
}
