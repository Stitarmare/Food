import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';

class WebViewPage extends StatefulWidget {
  String title;
  WebViewPage({this.title});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: STR_GOOGLE_URL,
      appBar: new AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        title: new Text(
          widget.title,
          style: TextStyle(
              fontSize: FONTSIZE_18,
              fontFamily: KEY_FONTFAMILY,
              fontWeight: FontWeight.w500,
              color: greytheme1200),
        ),
        elevation: 0.0,
      ),
    );
  }
}
