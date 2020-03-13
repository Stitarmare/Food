import 'package:flutter/material.dart';

class DialogsIndicator {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key, String text) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 10,
                            ),
                            text != ""
                                ? Text(
                                    text ?? "",
                                    style: TextStyle(color: Colors.blueAccent),
                                  )
                                : Container()
                          ]),
                    )
                  ]));
        });
  }

  
}
