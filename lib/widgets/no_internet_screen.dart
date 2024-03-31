import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.appBlackColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No internet connection!',
              // style: AppTextStyles.largeTextStyle,
            ),
            OutlinedButton(
              style: const ButtonStyle(
                  side: MaterialStatePropertyAll(BorderSide(
                // color: AppColors.blueColor,
              ))),
              onPressed: () {},
              child: const Text(
                'Retry',
                // style: AppTextStyles.buttonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
