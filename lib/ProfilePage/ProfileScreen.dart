import 'package:flutter/material.dart';
import 'package:foodzi/LandingPage/LandingView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //int _currentTabIndex = 0;
  File _image;

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    // SafeArea(

    // top: true,
    // bottom: true,
    // child:
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.2),
          child: Stack(overflow: Overflow.visible, children: <Widget>[
            Center(
                child: Image.asset(
              'assets/BlurImage/Group1612.png',
              height: MediaQuery.of(context).size.height * 0.35,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            )),
            // Container(
            //   child:
            Container(
              margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   width: 6,
                  // ),
                  FlatButton(
                    child: Image.asset('assets/BackButtonIcon/Path1621.png'),
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/MainWidget');
                    },
                  ),
                  SizedBox(
                    width: 10.2,
                  ),
                  Text(
                    "My Profile",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              // ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2.5,
              top: MediaQuery.of(context).size.height * 0.35 - 141,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  ClipOval(
                      child: _image == null
                          ? Image.asset(
                              'assets/ProfileImage/MaskGroup15.png',
                              fit: BoxFit.cover,
                              width: 82.5,
                              height: 82.5,
                            )
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                              width: 82.5,
                              height: 82.5,
                            )),
                  Positioned(
                    right: 0.0,
                    top: 5.0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialooxg();
                      },
                      // child: Container(
                      //   width: 23,
                      //   height: 23,
                      //   foregroundDecoration: BoxDecoration(
                      //     shape: BoxShape.circle,`
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/DineInImage/Group1504.png')),
                      //     )
                      //   ),
                      child: ClipOval(
                        child: Container(
                          width: 22,
                          height: 22,
                          color: orangetheme,
                          child:
                              Icon(Icons.edit, size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),

      body: SingleChildScrollView(child: _getMainView()),
      // ),
    );
  }

  Widget _getMainView() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(left: 36, right: 36),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 53,
              ),
              Text(
                'George Thomas',
                style: TextStyle(
                    fontSize: 16,
                    color: greytheme1200,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'gthomas45@hotmail.com | +61 9876 5432.',
                style: TextStyle(
                    fontSize: 14,
                    color: greytheme1200,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '600 Creswick Rd, Ballarat Central VIC 3350,Australia',
                style: TextStyle(
                    fontSize: 14,
                    color: greytheme1200,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 27,
              ),
              Divider(
                thickness: 2,
                endIndent: 72,
                indent: 72,
              ),
              SizedBox(
                height: 40,
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
              Navigator.pushNamed(context, '/EditProfileview');
            },
            child: new Text(
              KEY_EDIT_PROFILE,
              style: TextStyle(
                  color: greytheme1200,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'gotham',
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/ChangePasswordview');
            },
            child: new Text(
              KEY_CHANGE_PASSWORD,
              style: TextStyle(
                  color: greytheme1200,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'gotham',
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, null);
            },
            child: new Text(
              KEY_SETTINGS,
              style: TextStyle(
                  color: greytheme1200,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'gotham',
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, null);
            },
            child: new Text(
              KEY_HELP,
              style: TextStyle(
                  color: greytheme1200,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'gotham',
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  showDialooxg() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Text(
              'Select One',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: greentheme100,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w700),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  //Camera
                  getImage(true);
                  print("Camera");
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.camera),
                  title: Text(
                    'Camera',
                    style: TextStyle(
                        fontSize: 20,
                        color: greytheme100,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  //Gallery
                  getImage(false);
                  print("Gallery");
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.image),
                  title: Text(
                    'Gallery',
                    style: TextStyle(
                        fontSize: 20,
                        color: greytheme100,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
