import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';

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
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {});

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (state.type == WebViewState.startLoad) {}

      if (state.type == WebViewState.shouldStart &&
          state.url.contains("${BaseUrl.getBaseUrl()}success")) {
        print("onStateChanged: ${state.type} ${state.url}");
        setState(() {
          var urlsSplit = state.url.split("?");
          var checkOutCode = urlsSplit[0].split("/").last;
          Navigator.pop(context, {'check_out_code': checkOutCode});
          flutterWebviewPlugin.stopLoading();
          flutterWebviewPlugin.close();
        });
      }
      if (state.type == WebViewState.finishLoad) {
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
          title: new Text("Payment"),
          backgroundColor: orangetheme300,
        ));
  }
}
