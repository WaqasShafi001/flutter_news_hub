import 'package:flutter/material.dart';
import 'package:flutter_news_hub/utils/connectivity_service.dart';
import 'package:flutter_news_hub/widgets/no_internet_screen.dart';
import 'package:get/get.dart';

class InternetCheckWidget<T extends GetxController> extends StatelessWidget {
  final Widget child;
  final void Function(bool isSocketConnected)? onSocketStatusChanged;

  const InternetCheckWidget(
      {super.key, required this.child, this.onSocketStatusChanged});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final connectivityService = Get.find<ConnectivityService>();
      if (onSocketStatusChanged != null) {
        onSocketStatusChanged!(connectivityService.hasInternet.value);
      }
      if (!connectivityService.hasInternet.value) {
        return const NoInternetScreen();
      } else {
        return child;
      }
    });
  }
}
