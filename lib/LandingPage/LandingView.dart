import 'package:flutter/material.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/Drawer/drawer.dart';

class Landingview extends DrawerContent {
  Landingview({Key key, this.title});
  final String title;

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
            onPressed: widget.onMenuPressed
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
          text: Text('Home', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
          page: Landingview(
            title: 'Home',
          ),
        ),
        DrawerItem(
          text: Text(
            'Gallery',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.photo_album, color: Colors.white),
          page: Landingview(
            title: 'Gallery',
          ),
        ),
        DrawerItem(
          text: Text(
            'Favorites',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.favorite, color: Colors.white),
          page: Landingview(
            title: 'Favorites',
          ),
        ),
        DrawerItem(
          text: Text(
            'Notification',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.notifications, color: Colors.white),
          page: Landingview(
            title: 'Notification',
          ),
        ),
        DrawerItem(
          text: Text(
            'Invite',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.insert_invitation, color: Colors.white),
          page: Landingview(
            title: 'invite',
          ),
        ),
        DrawerItem(
          text: Text(
            'SETTINGS',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          page: Landingview(
            title: 'SETTINGS',
          ),
        ),
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
          child: Column(
            children: <Widget>[
              Container(
                // height: 75,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 5)),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                width: MediaQuery.of(context).size.width * 0.6,
                child: ClipOval(
                    // child: Image(
                    //   fit: BoxFit.contain,
                    //   // image: NetworkImage(
                    //   //   'https://scontent.fktm7-1.fna.fbcdn.net/v/t1.0-9/48405358_683680282028761_2233474687176802304_n.jpg?_nc_cat=111&_nc_oc=AQnJcz3nmJPgqG0Koen6EyPPOQktub5ubjD7KdFTstGLQRNrKupGp3hOZ-twJGEK2fM&_nc_ht=scontent.fktm7-1.fna&oh=caed7075e39bcdcd38b333395161516d&oe=5DD670D5',
                    //   // ),
                    // ),
                    ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Siddhartha joshi',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.deepPurple[500], Colors.purple[500], Colors.purple],
            // tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
