import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.2),
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Center(
                  child: Image.asset(
                'assets/BlurImage/Group1612.png',
                height: 180,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
              )),
              Container(
                //color: Colors.blueAccent,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 34, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "My Profile",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2.5,
                top: MediaQuery.of(context).size.height / 6.8,
                child: ClipOval(
                  //radius: 50,
                  // child: Card(
                  //   elevation: 10,
                  child: Image.asset(
                    'assets/ProfileImage/MaskGroup15.png',
                    fit: BoxFit.cover,
                    width: 82.5,
                    height: 82.5,
                  ),
                  // ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(child: _getMainView()),
      ),
    );
  }

  Widget _getMainView() {
    return Center(
      child: Container(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Text('George Thomas'),
          SizedBox(
            height: 10,
          ),
          Text('gthomas45@hotmail.com | +61 9876 5432.'),
          SizedBox(
            height: 10,
          ),
          Text('600 Creswick Rd, Ballarat Central VIC 3350,Australia'),
          SizedBox(
            height: 20,
          ),
          Divider(
            endIndent: 20,
            indent: 20,
          ),
          SizedBox(
            height: 30,
          ),
          _profileOptions()
        ],
      )),
    );
  }

  Widget _profileOptions() {
    return Container(
      child: Column(
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, null);
            },
            child: new Text(
              KEY_EDIT_PROFILE,
              style: TextStyle(
                  // color: greentheme100,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'gotham',
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, null);
            },
            child: new Text(
              KEY_CHANGE_PASSWORD,
              style: TextStyle(
                  // color: greentheme100,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'gotham',
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, null);
            },
            child: new Text(
              KEY_SETTINGS,
              style: TextStyle(
                  // color: greentheme100,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'gotham',
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, null);
            },
            child: new Text(
              KEY_HELP,
              style: TextStyle(
                  // color: greentheme100,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'gotham',
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
