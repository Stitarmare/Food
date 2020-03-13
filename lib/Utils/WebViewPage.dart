import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:foodzi/Models/PayCheckOutNetBanking.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:http/http.dart' as http;

class WebViewScreen extends StatefulWidget {
  String url;
  WebViewScreen({this.url});
  @override
  _WebViewScreenState createState() => new _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  String token;

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();
    

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
           if(state.type == WebViewState.startLoad){
         DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
      }
     
      if (state.type == WebViewState.shouldStart &&
          state.url.contains("http://foodzi.php-dev.in/success")) {

            //fetchJson(state.url);
             print("onStateChanged: ${state.type} ${state.url}");
            setState(() {
              var urlsSplit = state.url.split("?");
              var checkOutCode = urlsSplit[0].split("/").last;
              Navigator.pop(context,{'check_out_code':checkOutCode});
              flutterWebviewPlugin.stopLoading();
              flutterWebviewPlugin.close();
            });
            
      }
       if(state.type == WebViewState.finishLoad){
            Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
     
          print("URL changed: $url");
          
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String loginUrl = "http://${widget.url}";

    return new WebviewScaffold(
        url: loginUrl,
        appBar: new AppBar(
          // title: new Text("Payment"),
           brightness: Brightness.dark,
          title: new Text("Login to someservise..."),
          backgroundColor: orangetheme,
        ));
  }

}
 