import 'package:flutter/material.dart';
import 'package:flutter_news_hub/common/app_strings.dart';
import 'package:flutter_news_hub/features/authentication/presentation/controller/sign_in_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Center(
                  child: IconButton.outlined(
                    onPressed: () => controller.signInWithGoogle(),
                    style: ButtonStyle(
                      maximumSize: MaterialStatePropertyAll(
                        Size(width * 0.5, height * 0.1),
                      ),
                    ),
                    icon: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.google),
                        Text(
                          AppStrings.googleSignIn,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
