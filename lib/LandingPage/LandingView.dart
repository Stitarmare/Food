import 'package:flutter/material.dart';
import 'package:foodzi/theme/colors.dart';

class Landingview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingStateView();
  }
}

class _LandingStateView extends State<Landingview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.notifications,
              color: greytheme100,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
            icon: new Icon(
              Icons.menu,
              color: greytheme100,
            ),
            onPressed: () {}
            // _scaffoldKey.currentState.openDrawer()
            /// backgroundColor: Colors.blue,
            // title: Text('data'),
            ),
      ),
      body: SingleChildScrollView(child: _getmainView()),
    );
  }
}

Widget _getmainView() {
  return LimitedBox(
    child: Container(
      child: Column(
        children: <Widget>[
          _buildimage(),
          SizedBox(
            height: 25,
          ),
          _buildMaintext(),
          SizedBox(
            height: 16,
          ),
          _cardoption()
        ],
      ),
    ),
  );
}

Widget _buildimage() {
  return Image.asset(
    'assets/LandingImage/Group1561.png',
  );
}

Widget _buildMaintext() {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 30,
      ),
      _buidtext()
    ],
  );
}

Widget _buidtext() {
  return LimitedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hello',
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w500,
              color: greytheme100),
        ),
        SizedBox(
          height: 10,
        ),
        Text('George',
        style: TextStyle(
              fontSize: 32,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w600,
              color: greytheme500),),
        SizedBox(
          height: 12,
        ),
        Text('All your favourites at your fingertip !!',
        style: TextStyle(
              fontSize: 14,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w500,
              color: greytheme100))
      ],
    ),
  );
}

Widget _cardoption() {
  return LimitedBox(
    child: Container(
      child: Column(
        children: <Widget>[
          _dineincard(),
          SizedBox(
            height: 12,
          ),
          _takeAwaycard()
        ],
      ),
    ),
  );
}

Widget _dineincard() {
  return Center(
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          width: 345,
          height: 90,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 17,
              ),
              Image.asset('assets/DineInImage/Group1504.png'),
              SizedBox(
                width: 40,
              ),
              _buildinningtext(),
              SizedBox(
                width: 40,
              ),
              Icon(Icons.navigate_next,color: greytheme600,)
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildinningtext() {
  return Column(
    //mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 20,
      ),
      Text('Dine-in',
      style: TextStyle(
              fontSize: 20,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w600,
              color: greentheme100)),
      SizedBox(
        height: 15,
      ),
      Text('Get served in Restaurant',
      style: TextStyle(
              fontSize: 14,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w500,
              color: greytheme100)),
    ],
  );
}

Widget _takeAwaycard() {
  return Center(
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          width: 345,
          height: 90,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 17,
              ),
              Image.asset('assets/TakeAwayImage/Group1505.png'),
              SizedBox(
                width: 40,
              ),
              _buildTakeAwaytext(),
              SizedBox(
                width: 40,
              ),
              Icon(Icons.navigate_next,color: greytheme600,)
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildTakeAwaytext() {
  return Column(
    //mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 20,
      ),
      Text('Take Away',
      style: TextStyle(
              fontSize: 20,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w600,
              color: greentheme100)),
      SizedBox(
        height: 15,
      ),
      Text('Get served in Restaurant',
      style: TextStyle(
              fontSize: 14,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w500,
              color: greytheme100)),
    ],
  );
}
