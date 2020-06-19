import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/theme/colors.dart';

class WebViewPage extends StatefulWidget {
  String title;
  String strURL;
  WebViewPage({this.title, this.strURL});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.strURL,
      appBar: new AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Column(
          children: <Widget>[
            widget.title == STR_ABOUT_US
                ? Image.asset(FOODZI_LOGO_PATH, height: 50)
                : Container(),
            widget.title != STR_ABOUT_US
                ? Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: FONTSIZE_18,
                        fontFamily: Constants.getFontType(),
                        fontWeight: FontWeight.w500,
                        color: greytheme1200),
                  )
                : Text(""),
          ],
        ),
        elevation: 0.0,
      ),
    );
  }
}
