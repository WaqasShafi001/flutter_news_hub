import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxController {
  var hasInternet = true.obs;

  @override
  void onInit() {
    super.onInit();

    checkInternetConnectivity();
    listenToConnectivityChanges();
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    hasInternet.value = (connectivityResult.first != ConnectivityResult.none);
  }

  void listenToConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((event) {
      log('this is event $event');
      hasInternet.value = (event.first != ConnectivityResult.none);
    });
  }
}
