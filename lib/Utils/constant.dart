import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'dart:io' as io;
import 'package:foodzi/theme/colors.dart';

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
    return getScreenHeight(context) - padding.top;
  }

  static isAndroid() {
    return io.Platform.isAndroid;
  }

  static isIOS() {
    return io.Platform.isIOS;
  }

  static String getFontType() {
    if (isIOS()) {
      return "SanFrancisco";
    } else if (isAndroid()) {
      return "Roboto";
    }
  }

  static void showAlert(String title, String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  Divider(
                    endIndent: 15,
                    indent: 15,
                    color: Colors.black,
                  ),
                  FlatButton(
                    child: Text(STR_OK),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ));
  }

  static void showAlertSuccess(
      String title, String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FONTSIZE_18,
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.w600,
                      color: greytheme700),
                ),
                content:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Image.asset(
                    SUCCESS_IMAGE_PATH,
                    width: 75,
                    height: 75,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: Constants.getFontType(),
                        fontWeight: FontWeight.w500,
                        color: greytheme700),
                  )
                ]),
                actions: <Widget>[
                  Divider(
                    endIndent: 15,
                    indent: 15,
                    color: Colors.black,
                  ),
                  FlatButton(
                    child: Text(STR_OK,
                        style: TextStyle(
                            fontSize: FONTSIZE_16,
                            fontFamily: Constants.getFontType(),
                            fontWeight: FontWeight.w600,
                            color: greytheme700)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ));
  }

  static Widget steppercount(int text) {
    Row(children: <Widget>[
      InkWell(
        onTap: () {
          text++;
        },
        splashColor: Colors.redAccent.shade200,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              Icons.remove,
              color: Colors.redAccent,
              size: 20,
            ),
          ),
        ),
      ),
      SizedBox(
        width: 4,
      ),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text.toString()),
        ),
      ),
      SizedBox(
        width: 4,
      ),
      InkWell(
        onTap: () {
          text--;
        },
        splashColor: Colors.lightBlue,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              Icons.add,
              color: greentheme,
              size: 20,
            ),
          ),
        ),
      ),
    ]);
  }

  static void buttoncollection(String title) {}
}
