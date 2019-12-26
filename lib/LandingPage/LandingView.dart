import 'package:flutter/material.dart';

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
            icon: new Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(icon: new Icon(Icons.menu), onPressed: () {}
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
            height: 10,
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
        Text('Hello'),
        SizedBox(
          height: 10,
        ),
        Text('George'),
        SizedBox(
          height: 10,
        ),
        Text('All your favourites at your fingertip !!')
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
              Icon(Icons.navigate_next)
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
      Text('Dine-in'),
      SizedBox(
        height: 15,
      ),
      Text('Get served in Restaurant'),
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
              Icon(Icons.navigate_next)
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
      Text('Take Away'),
      SizedBox(
        height: 15,
      ),
      Text('Get served in Restaurant'),
    ],
  );
}
