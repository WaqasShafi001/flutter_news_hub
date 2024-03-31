import 'package:flutter/material.dart';
import 'package:flutter_news_hub/common/app_colors.dart';
import 'package:flutter_news_hub/common/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String postUrl;
  const ArticleView({super.key, required this.postUrl});

  @override
  ArticleViewState createState() => ArticleViewState();
}

class ArticleViewState extends State<ArticleView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.postUrl));
    // #enddocregion webview_controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.blueColor),
        centerTitle: true,
        title: const Text(
          AppStrings.appName,
          style: TextStyle(
              color: AppColors.blueColor, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.whiteColor,
        elevation: 0.0,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
