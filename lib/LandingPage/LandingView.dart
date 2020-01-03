import 'package:flutter/material.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/Drawer/drawer.dart';

class Landingview extends DrawerContent {
  Landingview({Key key, this.title, this.isOpen});
  final String title;
  final bool isOpen;
  @override
  State<StatefulWidget> createState() {
    return _LandingStateView();
  }
}

class _LandingStateView extends State<Landingview> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 100.0,
      child: Scaffold(
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
          // leading: new IconButton(
          //     icon: new Icon(
          //       Icons.menu,
          //       color: greytheme100,
          //     ),
          //     onPressed: widget.onMenuPressed
          //     // _scaffoldKey.currentState.openDrawer()
          //     /// backgroundColor: Colors.blue,
          //     // title: Text('data'),
          //     ),
          leading: IconButton(
            icon: Image.asset('assets/MenuIcon/menu.png'),
            onPressed: widget.onMenuPressed,
          ),
        ),
        body: SingleChildScrollView(child: _getmainView()),
      ),
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
        Text(
          'George',
          style: TextStyle(
              fontSize: 32,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w600,
              color: greytheme500),
        ),
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
              Icon(
                Icons.navigate_next,
                color: greytheme600,
              )
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
              Icon(
                Icons.navigate_next,
                color: greytheme600,
              )
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

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  HiddenDrawerController _drawerController;
  @override
  void initState() {
    super.initState();
    _drawerController = HiddenDrawerController(
      initialPage: Landingview(
        title: 'main',
      ),
      items: [
        DrawerItem(
            text: Text('Home',
                style: TextStyle(
                    color: greytheme800,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
            icon: Icon(Icons.home, size: 20, color: greytheme800),
            page: Landingview(
              title: 'Home',
            ),
            onPressed: null),
        DrawerItem(
            text: Text('Settings',
                style: TextStyle(
                    color: greytheme800,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
            icon: Icon(Icons.settings, size: 20, color: greytheme800),
            page: Landingview(
              title: 'Gallery',
            ),
            onPressed: null),
        DrawerItem(
            text: Text(
              'Terms & Conditions',
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            icon: Icon(Icons.description, size: 20, color: greytheme800),
            page: Landingview(
              title: 'Favorites',
            ),
            onPressed: null),
        DrawerItem(
            text: Text(
              'Privacy Policy',
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            icon: Icon(Icons.verified_user, size: 20, color: greytheme800),
            page: Landingview(
              title: 'Notification',
            ),
            onPressed: null),
        DrawerItem(
            text: Text(
              'About Us',
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            icon: Icon(Icons.info, size: 20, color: greytheme800),
            page: Landingview(
              title: 'invite',
            ),
            onPressed: null),
        DrawerItem(
            text: Text(
              'Help',
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            icon: Icon(
              Icons.help,
              color: greytheme800,
              size: 20,
            ),
            page: Landingview(
              title: 'SETTINGS',
            ),
            onPressed: null),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HiddenDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Column(
              children: <Widget>[
                Container(
                  // height: 75,
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   //border: Border.all(color: Colors.red, width: 1)
                  // ),
                  // padding: EdgeInsets.only(left: 2.0),
                  //width: MediaQuery.of(context).size.width * 0.3,
                  // child: Padding(
                  //   padding: EdgeInsets.only(left: 5.0),
                  child: ClipOval(
                      child: Image.asset(
                    'assets/ProfileImage/MaskGroup15@3x.png',
                    width: 70,
                    height: 70,
                  )),
                ),
                // ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'George Thomas',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: greytheme700,
                        fontSize: 16,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          // gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [Colors.deepPurple[500], Colors.purple[500], Colors.purple],
          //   // tileMode: TileMode.repeated,
          // ),
        ),
      ),
    );
  }
}
