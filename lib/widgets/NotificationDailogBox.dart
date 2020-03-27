import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';

enum DailogAction { yes, abort }

class DailogBox {
  static Future<DailogAction> notification_1(
    BuildContext context,
    String recipientName,
    String recipientMobno,
    String tableno,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.only(top: 123, bottom: 180),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: 336,
                width: 284,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        STR_JOINING_TABLE,
                        style: TextStyle(
                            fontSize: FONTSIZE_16,
                            color: Color.fromRGBO(64, 64, 64, 1)),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '$recipientName,',
                              style: TextStyle(
                                  color: Color.fromRGBO(55, 180, 76, 1),
                                  fontSize: FONTSIZE_16),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              recipientMobno,
                              style: TextStyle(
                                  color: Color.fromRGBO(64, 64, 64, 1),
                                  fontSize: FONTSIZE_14),
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              STR_IS_TRYING_TO_ADD,
                              style: TextStyle(
                                  fontSize: FONTSIZE_13,
                                  color: Color.fromRGBO(64, 64, 64, 1)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              STR_TABLE_NUMBER_SMALL,
                              style: TextStyle(
                                  fontSize: FONTSIZE_13,
                                  color: Color.fromRGBO(64, 64, 64, 1)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              tableno,
                              style: TextStyle(
                                  fontSize: FONTSIZE_24,
                                  color: Color.fromRGBO(55, 180, 76, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Color.fromRGBO(55, 180, 76, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
                            child: Text(
                              STR_JOIN,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FONTSIZE_18,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context, DailogAction.yes);
                          },
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromRGBO(170, 170, 170, 1)),
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            Navigator.pop(context, DailogAction.abort);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
                            child: Text(
                              STR_REJECT,
                              style: TextStyle(
                                color: Color.fromRGBO(118, 118, 118, 1),
                                fontSize: FONTSIZE_18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
    return (action != null) ? action : DailogAction.abort;
  }
}
