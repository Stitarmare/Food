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
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.strURL,
      appBar: new AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        //backgroundColor: Colors.transparent,
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
                                  : greentheme100,
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
