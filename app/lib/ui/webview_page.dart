import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String link;

  WebViewPage({Key? key, required this.link}) : super(key: key);

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.dark;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _currentStyle,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: WebView(
            initialUrl: '${widget.link}',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) {},
          ),
        ),
      ),
    );
  }
}
