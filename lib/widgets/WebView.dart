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
        title: Column(
          children: <Widget>[
            widget.title == STR_ABOUT_US
                ? Image.asset(FOODZI_LOGO_PATH, height: 40)
                : Container(),
            Padding(
              padding: widget.title == STR_ABOUT_US
                  ? const EdgeInsets.only(bottom: 2.0)
                  : EdgeInsets.all(0),
              child: new Text(
                widget.title,
                style: TextStyle(
                    fontSize: FONTSIZE_18,
                    fontFamily: Constants.getFontType(),
                    fontWeight: FontWeight.w500,
                    color: greytheme1200),
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
    );
  }
}
