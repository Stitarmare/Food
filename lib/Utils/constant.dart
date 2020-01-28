import 'package:flutter/material.dart';
import 'dart:io' as io;

class Constants {
  static getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static getSafeAreaHeight(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    return getScreenHeight(context) - padding.top - padding.bottom;
  }

  static getSafeAreaHeightWOStatusBar(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
// height without status bar
    return getScreenHeight(context) - padding.top;
  }

  static isAndroid() {
    return io.Platform.isAndroid;
  }

  static isIOS() {
    return io.Platform.isIOS;
  }

  static void showAlert(String title, String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                Divider(
                  endIndent: 15,
                  indent: 15,
                  color: Colors.black,
                ),
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  static void buttoncollection(String title) {}
}
