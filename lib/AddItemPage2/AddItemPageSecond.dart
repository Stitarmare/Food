import 'package:flutter/material.dart';
import 'package:foodzi/theme/colors.dart';

class AddItemPageSecond extends StatefulWidget {
  AddItemPageSecond({Key key}) : super(key: key);

  _AddItemPageSecondState createState() => _AddItemPageSecondState();
}

class _AddItemPageSecondState extends State<AddItemPageSecond> {
  ScrollController _controller = ScrollController();
  // FLCountStepperController _stepperController =
  //     FLCountStepperController(defaultValue: 2, min: 0, max: 10, step: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/SplashScreen/LauncherScreen.png',
                    //width: 300,
                    height: 180,
                    //fit: BoxFit.cover,
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
                  Text(
                    "Lorem Epsom is simply dummy text",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: greytheme700),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Quantity:',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: greytheme700),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
