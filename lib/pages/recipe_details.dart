
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeDetailes extends StatelessWidget {
  final url ;

  const RecipeDetailes({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey.shade300),
          elevation: 1,
          title: Text(
            "R E C I P E  D E T A I L S",
            style: TextStyle(color: Colors.grey.shade300),
          ),
          centerTitle: true,
          backgroundColor: Colors.greenAccent.shade700,
        ),
        body: SafeArea(
          child: WebView(
            initialUrl: url,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String url) {
              // Show loading indicator
              // You can use a CircularProgressIndicator or any other loading indicator widget
            },
            onPageFinished: (String url) {
              // Hide loading indicator
            },
          ),
        ));
  }
}