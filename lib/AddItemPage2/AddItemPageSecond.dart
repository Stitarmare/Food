import 'package:flutter/material.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/theme/colors.dart';

class AddItemPageSecond extends StatefulWidget {
  AddItemPageSecond({Key key}) : super(key: key);

  _AddItemPageSecondState createState() => _AddItemPageSecondState();
}

class _AddItemPageSecondState extends State<AddItemPageSecond> {
  ScrollController _controller = ScrollController();
  List<bool> isSelected;

  int count = 1;
  // FLCountStepperController _stepperController =
  //     FLCountStepperController(defaultValue: 2, min: 0, max: 10, step: 1);
  @override
  void initState() {
    // TODO: implement initState
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            _getmainviewTableno(),
            SliverToBoxAdapter(
              child: Container(
                child: SizedBox(
                  height: 12,
                ),
              ),
            ),
            _menuItemDetail(),
            // _getOptionsformenu(context),
            SliverToBoxAdapter(
              child: Container(
                child: SizedBox(
                  height: 15,
                ),
              ),
            ),
            // _menuItemList()
          ],
        ),
        bottomNavigationBar: Container(
          //margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          width: MediaQuery.of(context).size.width,
          height: 54,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Text(
              'ADD \$ 24',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            color: redtheme,
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget _getmainviewTableno() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: new BoxDecoration(
            //color: Colors.green,
            borderRadius: new BorderRadius.all(Radius.circular(10.0))),
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'Wimpy',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w600,
                          color: greytheme700),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                //endIndent: 10,
                //indent: 10,
              ),
              Row(
                children: <Widget>[
                  // SizedBox(
                  //   width: 26,
                  // ),
                  // Image.asset('assets/DineInImage/Group1504.png'),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Dine-in',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: redtheme),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Add Table Number',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        fontSize: 14,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: greytheme100),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItemDetail() {
    return SliverToBoxAdapter(
      child: Container(
        // margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(26, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/SplashScreen/LauncherScreen.png',
                    //width: 300,
                    height: 180,
                    // fit: BoxFit.cover,
                    // height: 500.0,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Chicken Cordon",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: greytheme700),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Lorem Epsom is simply dummy text",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w400,
                        color: greytheme1000),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 22, 25, 22),
              child: Row(
                children: <Widget>[
                  Text(
                    'Quantity:',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w500,
                        color: greytheme700),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  steppercount(),
                  // Row(children: <Widget>[
                  //   InkWell(
                  //     onTap: () {},
                  //     //splashColor: Colors.redAccent.shade200,
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         color: redtheme,
                  //           borderRadius: BorderRadius.all(Radius.circular(4))),
                  //       alignment: Alignment.center,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(6.0),
                  //         child: Icon(
                  //           Icons.remove,
                  //           color: Colors.white,
                  //           size: 20,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     width: 4,
                  //   ),
                  //   Card(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text('2',  style: TextStyle(
                  //       fontSize: 16,
                  //       fontFamily: 'gotham',
                  //       fontWeight: FontWeight.w500,
                  //       color: greytheme700),),
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     width: 4,
                  //   ),
                  //   InkWell(
                  //     onTap: () {},
                  //     //splashColor: Colors.redAccent.shade200,
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         color: redtheme,
                  //           borderRadius: BorderRadius.all(Radius.circular(4))),
                  //       alignment: Alignment.center,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(6.0),
                  //         child: Icon(
                  //           Icons.add,
                  //           color: Colors.white,
                  //           size: 20,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ]
                  // )
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 28),
                  Text(
                    'Dressing',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w500,
                        color: greytheme700),
                  ),
                  SizedBox(
                    width: 34,
                  ),
                  Container(
                    height: 36,
                    child: ToggleButtons(
                      borderColor: greytheme1300,
                      fillColor: redtheme,
                      borderWidth: 2,
                      selectedBorderColor: Colors.transparent,
                      selectedColor: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      children: <Widget>[
                        Container(
                          width: 85,
                          child: Text(
                            'On side',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'gotham',
                                fontWeight: FontWeight.w500,
                                color: (isSelected[0] == true)
                                    ? Colors.white
                                    : greytheme700),
                          ),
                        ),
                        Container(
                          width: 85,
                          child: Text(
                            'On top',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'gotham',
                                fontWeight: FontWeight.w500,
                                color: (isSelected[1] == false)
                                    ? greytheme700
                                    : Colors.white),
                          ),
                        ),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < isSelected.length; i++) {
                            if (i == index) {
                              isSelected[i] = true;
                            } else {
                              isSelected[i] = false;
                            }
                          }
                        });
                      },
                      isSelected: isSelected,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget steppercount() {
    return Container(
      height: 24,
      width: 92,
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
            padding: const EdgeInsets.only(left: 13,right: 13),
            child: Text(count.toString(),style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w600,
                          color: greytheme700),),
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
}