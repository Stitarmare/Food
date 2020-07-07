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
                    fontWeight: FontWeight.w500,
                    color: greytheme1200),
              )
            : Image.asset(FODDZI_LOGO_3X, height: 50),
        elevation: 0.0,
        // leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     }),
      ),
      bottomNavigationBar: widget.flag == 2
          ? BottomAppBar(
              child: Container(
                height: 55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        Navigator.pushReplacementNamed(context, STR_LOGIN_PAGE);
                      },
                      child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                              color: ((Globle().colorscode) != null)
                                  ? getColorByHex(Globle().colorscode)
                                  : greentheme400,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          child: Center(
                            child: Text(
                              STR_I_AGREE,
                              style: TextStyle(
                                  fontFamily: KEY_FONTFAMILY,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FONTSIZE_16,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )
          : Text(""),
    );
  }
}
