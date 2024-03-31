import 'package:flutter/material.dart';
import 'package:flutter_news_hub/common/app_strings.dart';
import 'package:flutter_news_hub/features/authentication/presentation/binding/sign_in_binding.dart';
import 'package:flutter_news_hub/features/authentication/presentation/view/sign_in_view.dart';
import 'package:flutter_news_hub/widgets/internet_check_widget.dart';
import 'package:get/get.dart';

import 'utils/connectivity_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
        (value) => Get.to(() => const SignInPage(), binding: SignInBinding()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Center(
          child: Text(
            AppStrings.appName,
          ),
        ),
      ),
    );
  }
}
