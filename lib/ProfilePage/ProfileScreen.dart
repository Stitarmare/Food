import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/LandingPage/LandingView.dart';
import 'package:foodzi/ProfilePage/ProfileScreenContractor.dart';
import 'package:foodzi/ProfilePage/ProfileScreenPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/ClipOvalImageLoader.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    implements ProfileScreenModelView {
  //int _currentTabIndex = 0;
  ProfileScreenPresenter profileScreenPresenter;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  File _image;
  bool isempty = false;

  String imageURL = "";
  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
      //setProfilePic();
    });
    if (image != null) {
      profileScreenPresenter.updateProfileImage(_image, context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    profileScreenPresenter = ProfileScreenPresenter(this);
    super.initState();
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
              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
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
                                      child: CachedNetworkImage(
                        width: 83,
                        height: 83,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        imageUrl: profilePic(),
                      ),
                  ),
                  //  FadeInImage.assetNetwork(
                  //   placeholder: 'assets/PlaceholderImage/placeholder.png',
                  //   image: profilePic(),
                  //   fit: BoxFit.cover,
                  //   width: 82.5,
                  //   height: 82.5,
                  // ),
                  //     Image.network(profilePic(),
                  //         fit: BoxFit.cover,
                  //         width: 82.5,
                  //         height: 82.5, loadingBuilder: (BuildContext context,
                  //             Widget child, ImageChunkEvent loadingProgress) {
                  //   if (loadingProgress == null || profilePic() == null) return child;
                  //   return Center(
                  //     child: CircularProgressIndicator(
                  //       value: loadingProgress.expectedTotalBytes != null
                  //           ? loadingProgress.cumulativeBytesLoaded /
                  //               loadingProgress.expectedTotalBytes
                  //           : null,
                  //     ),
                  //   );
                  // }),

                  //setProfilePic(),
                  //ClipOvalImageWithLoader(profilePic(),width: 83,height: 83,),
                  

                  //   CachedNetworkImage(
                  // imageUrl: profilePic(),
                  // placeholder: (context, url) =>
                  //     CircularProgressIndicator(),
                  // errorWidget: (context, url, error) => Icon(Icons.error),
                  // fit: BoxFit.cover,
                  // width: 82.5,
                  // height: 82.5,

                  // child: _image == null
                  //     //Globle().loginModel.data.userDetails.profileImage == null
                  //     ? Image.asset(
                  //         'assets/ProfileImage/MaskGroup15.png',
                  //         fit: BoxFit.cover,
                  //         width: 82.5,
                  //         height: 82.5,
                  //       )

                  //     : Image.file(
                  //         _image,
                  //         //BaseUrl.getBaseUrlImages()+'${Globle().loginModel.data.userDetails.profileImage},',
                  //         fit: BoxFit.cover,
                  //         width: 82.5,
                  //         height: 82.5,
                  //       )

                  Positioned(
                    right: 0.0,
                    top: 5.0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialooxg();
                        //  DialogsIndicator.showLoadingDialog(
                        // context, _keyLoader, "Loading");
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
                '${Globle().loginModel.data.firstName ?? ""} ${Globle().loginModel.data.lastName ?? ""}',
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
                "${Globle().loginModel.data.mobileNumber}",
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
                // (Globle().loginModel.data.userDetails != null )
                //     ? "${Globle().loginModel.data.userDetails.country.name} | ${Globle().loginModel.data.userDetails.addressLine1}"
                //     : "N.A.",
                address(),
                style: TextStyle(
                    fontSize: 14,
                    color: greytheme1200,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w500),
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

  address() {
    String userAddress = "N.A.";
    String address1 = "N.A..";
    String address2 = "N.A.";
    if (Globle().loginModel.data.userDetails != null) {
      if (Globle().loginModel.data.userDetails.country != null) {
        if (Globle().loginModel.data.userDetails.country.name != null) {
          address1 = Globle().loginModel.data.userDetails.country.name;
        }
      }
      address2 = (Globle().loginModel.data.userDetails.addressLine1 != null)
          ? Globle().loginModel.data.userDetails.addressLine1
          : "N.A.";
      userAddress = "$address1 | $address2";
      return userAddress;
    }
    return userAddress;
  }

  profilePic() {
    String imageUrl = imageURL;
    if (Globle().loginModel.data.userDetails != null) {
      imageUrl = (Globle().loginModel.data.userDetails.profileImage != null)
          ? BaseUrl.getBaseUrlImages() +
              '${Globle().loginModel.data.userDetails.profileImage}'
          : 'assets/PlaceholderImage/placeholder.png';
      return imageUrl;
    }
    return imageUrl;
  }

  // Widget setProfilePic() {
  //   return ClipOval(
  //     child: FutureBuilder(
  //       // Paste your image URL inside the htt.get method as a parameter
  //       future: http.get(
  //         profilePic(),
  //       ),
  //       builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
  //         switch (snapshot.connectionState) {
  //           case ConnectionState.none:
  //             return Text('Press button to start.');
  //           case ConnectionState.active:
  //           case ConnectionState.waiting:
  //             return CircularProgressIndicator();
  //           case ConnectionState.done:
  //             if (snapshot.hasError) return Text('Error: ${snapshot.error}');
  //             // when we get the data from the http call, we give the bodyBytes to Image.memory for showing the image
  //             return Image.memory(
  //               snapshot.data.bodyBytes,
  //               fit: BoxFit.cover,
  //               width: 82.5,
  //               height: 82.5,
  //             );
  //         }
  //         return null; // unreachable
  //       },
  //     ),
  //   );
  // }

  @override
  void profileImageUpdateFailed() {
    // TODO: implement profileImageUpdateFailed
  }
  @override
  void profileImageUpdateSuccess() {
    setState(() {
      imageURL = BaseUrl.getBaseUrlImages() +
          '${Globle().loginModel.data.userDetails.profileImage}';
    });
    //setProfilePic();

    //CircularProgressIndicator();
    //  DialogsIndicator.showLoadingDialog(
    //                   context, _keyLoader, "Loading");
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    //   SnackBar(content: Text("Profile updated successfully."));
    // }
  }
}
