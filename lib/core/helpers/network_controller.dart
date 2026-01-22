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

    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      // Take first result OR check if ANY connectivity is available
      _updateConnectionStatus(result);
    });
  }

  void _initConnectivityCheck() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final newStatus = results.isNotEmpty && results.first != ConnectivityResult.none;

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
