import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';

class WebViewPage extends StatefulWidget {
  String title;
  String strURL;
  int flag;
  WebViewPage({this.title, this.strURL, this.flag});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.strURL,
      appBar: new AppBar(
        iconTheme: IconThemeData(
            color: widget.title == STR_ABOUT_US ? Colors.black : Colors.white),
        centerTitle: true,
        brightness: Brightness.dark,
        backgroundColor:
            widget.title == STR_ABOUT_US ? Colors.transparent : null,
        title: widget.title != STR_ABOUT_US
            ? Text(
                widget.title,
                style: TextStyle(
                    fontSize: FONTSIZE_18,
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w600,
                    // color: greytheme1200
                    color: Colors.white),
              )
            : Image.asset(FODDZI_LOGO_3X, height: 50),
        elevation: 0.0,
      ),
    );
  }
}
