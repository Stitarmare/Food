import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/RadioDailog.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OrderConfirmation2View extends StatefulWidget {
  OrderConfirmation2View({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _OrderConfirmation2ViewState();
  }
}

class _OrderConfirmation2ViewState extends State<OrderConfirmation2View> {
  String _selectedId;
  int count = 1;
  void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }

  Widget steppercount() {
    return Container(
      height: 24,
      width: 150,
      child: Row(children: <Widget>[
        InkWell(
          onTap: () {
            if (count > 1) {
              setState(() {
                --count;
                print(count);
              });
            }
          },
          splashColor: Colors.redAccent.shade200,
          child: Container(
            decoration: BoxDecoration(
                color: redtheme,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            alignment: Alignment.center,
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13, right: 13),
          child: Text(
            count.toString(),
            style: TextStyle(
                fontSize: FONTSIZE_16,
                fontFamily: Constants.getFontType(),
                fontWeight: FontWeight.w600,
                color: greytheme700),
          ),
        ),
        InkWell(
          onTap: () {
            if (count < 10) {
              setState(() {
                ++count;
                print(count);
              });
            }
          },
          splashColor: Colors.lightBlue,
          child: Container(
            decoration: BoxDecoration(
                color: redtheme,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            alignment: Alignment.center,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: true,
      right: true,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            _getmainviewTableno(),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 2,
            ),
            SizedBox(
              height: 10,
            ),
            _getAddedListItem()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 102,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      child: Text(
                        STR_ADD_MORE_ITEM,
                        style: TextStyle(
                            fontSize: FONTSIZE_16,
                            fontFamily: Constants.getFontType(),
                            decoration: TextDecoration.underline,
                            decorationColor: redtheme,
                            color: redtheme,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              child: new RadioDialog(
                                onValueChange: _onValueChange,
                                initialValue: _selectedId,
                              ));
                        },
                        child: Container(
                          height: 54,
                          width: (MediaQuery.of(context).size.width / 2) - 15,
                          decoration: BoxDecoration(
                              color: redtheme,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          child: Center(
                            child: Text(
                              STR_MAKE_PAYMENT,
                              style: TextStyle(
                                  fontFamily: Constants.getFontType(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FONTSIZE_16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              child: new RadioDialog(
                                onValueChange: _onValueChange,
                                initialValue: _selectedId,
                              ));
                        },
                        child: Container(
                          height: 54,
                          width: (MediaQuery.of(context).size.width / 2) - 15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              STR_PLACE_ORDER,
                              style: TextStyle(
                                  fontFamily: Constants.getFontType(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: FONTSIZE_16,
                                  color: greytheme1000),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget _getmainviewTableno() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 6, left: 20),
                child: Text(
                  STR_WIMPY_TITLE,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: FONTSIZE_20,
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.w600,
                      color: greytheme700),
                ),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Text(
                  STR_DINEIN_TITLE,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: FONTSIZE_20,
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.w600,
                      color: redtheme),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Text(
                  STR_ADD_TABLE,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      fontSize: FONTSIZE_14,
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.w600,
                      color: greytheme100),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _getAddedListItem() {
    return Expanded(
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Image.asset(
                          IMAGE_VEG_ICON_PATH,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            STR_ITEM_NAME,
                            style: TextStyle(
                                fontSize: FONTSIZE_18, color: greytheme700),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 30,
                            width: 180,
                            child: AutoSizeText(
                              STR_ITEM_DESC,
                              style: TextStyle(
                                color: greytheme1000,
                                fontSize: FONTSIZE_14,
                              ),
                              maxFontSize: FONTSIZE_12,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(height: 10),
                          steppercount(),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 80,
                        ),
                        flex: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20, top: 30),
                        child: Text(
                          STR_SEVENTEEN_TITLE,
                          style: TextStyle(
                              color: greytheme700,
                              fontSize: FONTSIZE_16,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                SizedBox(height: 12),
                Divider(
                  height: 2,
                  thickness: 2,
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
