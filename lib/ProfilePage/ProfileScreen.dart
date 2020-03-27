import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/ProfilePage/ProfileScreenContractor.dart';
import 'package:foodzi/ProfilePage/ProfileScreenPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    implements ProfileScreenModelView {
  ProfileScreenPresenter profileScreenPresenter;
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
    });
    if (image != null) {
      profileScreenPresenter.updateProfileImage(_image, context);
    }
  }

  @override
  void initState() {
    profileScreenPresenter = ProfileScreenPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.2),
          child: Stack(overflow: Overflow.visible, children: <Widget>[
            Center(
                child: Image.asset(
              ITEM_IMAGE_PATH,
              height: MediaQuery.of(context).size.height * 0.35,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            )),
            Container(
              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FlatButton(
                    child: Image.asset(BACK_ARROW_IMAGE_PATH),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/MainWidget');
                    },
                  ),
                  SizedBox(
                    width: 10.2,
                  ),
                  Text(
                    STR_MY_PROFILE,
                    style: TextStyle(
                        fontSize: FONTSIZE_18,
                        color: Colors.white,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
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
                      placeholder: (context, url) => Image.asset(
                        PROFILE_IMAGE_PATH,
                        width: 83,
                        height: 83,
                        fit: BoxFit.fill,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        PROFILE_IMAGE_PATH,
                        width: 83,
                        height: 83,
                        fit: BoxFit.fill,
                      ),
                      imageUrl: profilePic(),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    top: 5.0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDialooxg();
                      },
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
                    fontSize: FONTSIZE_16,
                    color: greytheme1200,
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "${Globle().loginModel.data.mobileNumber}",
                style: TextStyle(
                    fontSize: FONTSIZE_14,
                    color: greytheme1200,
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                address(),
                style: TextStyle(
                    fontSize: FONTSIZE_14,
                    color: greytheme1200,
                    fontFamily: KEY_FONTFAMILY,
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
                  fontFamily: KEY_FONTFAMILY,
                  fontSize: FONTSIZE_18),
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
                  fontFamily: KEY_FONTFAMILY,
                  fontSize: FONTSIZE_18),
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
                  fontFamily: KEY_FONTFAMILY,
                  fontSize: FONTSIZE_18),
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
                  fontFamily: KEY_FONTFAMILY,
                  fontSize: FONTSIZE_18),
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
              STR_SELECT_ONE,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FONTSIZE_22,
                  color: greentheme100,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w700),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  getImage(true);
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.camera),
                  title: Text(
                    STR_CAMERA,
                    style: TextStyle(
                        fontSize: FONTSIZE_20,
                        color: greytheme100,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  getImage(false);
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.image),
                  title: Text(
                    STR_GALLERY,
                    style: TextStyle(
                        fontSize: FONTSIZE_20,
                        color: greytheme100,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          );
        });
  }

  address() {
    String userAddress = STR_NA;
    String address1 = STR_NA;
    String address2 = STR_NA;
    if (Globle().loginModel.data.userDetails != null) {
      if (Globle().loginModel.data.userDetails.country != null) {
        if (Globle().loginModel.data.userDetails.country.name != null) {
          address1 = Globle().loginModel.data.userDetails.country.name;
        }
      }
      address2 = (Globle().loginModel.data.userDetails.addressLine1 != null)
          ? Globle().loginModel.data.userDetails.addressLine1
          : STR_NA;
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
          : PROFILE_IMAGE_PATH;
      return imageUrl;
    }
    return imageUrl;
  }

  @override
  void profileImageUpdateFailed() {}
  @override
  void profileImageUpdateSuccess() {
    setState(() {
      imageURL = BaseUrl.getBaseUrlImages() +
          '${Globle().loginModel.data.userDetails.profileImage}';
    });
  }
}
