import 'package:flutter/material.dart';

enum DailogAction { yes, abort }

class Dailogs{
static Future<DailogAction> notification_1(
    BuildContext context,
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
                        'Joining a table?',
                        style: TextStyle(
                            fontSize: 16, color: Color.fromRGBO(64, 64, 64, 1)),
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
                              'Ritu Budhouliya,',
                              style: TextStyle(
                                  color: Color.fromRGBO(55, 180, 76, 1),
                                  fontSize: 16),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '+91-8409898409',
                              style: TextStyle(
                                  color: Color.fromRGBO(64, 64, 64, 1),
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'is trying to add you for',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(64, 64, 64, 1)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'table number',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(64, 64, 64, 1)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '8',
                              style: TextStyle(
                                  fontSize: 24,
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
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // SizedBox(
                        //   width:10,
                        // ),
                        RaisedButton(
                          color: Color.fromRGBO(55, 180, 76, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
                            child: Text(
                              'JOIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        RaisedButton(
                          // color: Color.fromRGBO(170, 170, 170, 1),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromRGBO(170, 170, 170, 1)),
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
                            child: Text(
                              'REJECT',
                              style: TextStyle(
                                color: Color.fromRGBO(118, 118, 118, 1),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
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