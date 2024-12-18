import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OpenNews extends StatefulWidget {
  String newsUrl;
  OpenNews({super.key, required this.newsUrl});

  @override
  State<OpenNews> createState() => _OpenNewsState();
}

class _OpenNewsState extends State<OpenNews> {
  late WebViewController webViewController;



  @override
  void initState() {
    webViewController = WebViewController()
      ..loadRequest(
        Uri.parse(widget.newsUrl),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News"),),
      body: (webViewController==null) 
      ?Center(child: CircularProgressIndicator(),)
      :WebViewWidget(controller: webViewController),
    );
  }
}
