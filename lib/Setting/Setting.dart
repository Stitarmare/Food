import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/EnterMobileNoPage/EnterMobileNoPage.dart';
import 'package:foodzi/Login/LoginView.dart';
import 'package:foodzi/Setting/DeleteAccContractor.dart';
import 'package:foodzi/Setting/DeleteAccPresenter.dart';
import 'package:foodzi/Setting/NotificationSetting.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/NotificationDailogBox.dart';
import 'package:toast/toast.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView>
    implements DeleteAccModelView {
  var action;
  DeleteAccPresenter deleteAccPresenter;
  @override
  void initState() {
    deleteAccPresenter = DeleteAccPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        elevation: 0.0,
        title: Text(
          STR_SETTING,
          style: TextStyle(
              fontSize: FONTSIZE_18,
              fontFamily: KEY_FONTFAMILY,
              fontWeight: FontWeight.w500,
              color: greytheme1200),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationSetting()));
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationSetting()));
                // final action = await DailogBox.settingDialog(context,'Notification Settings?', 'Enable', 'Disable');
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 25, top: 10, bottom: 10),
                    child: Text(
                      'Notification Settings',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: KEY_FONTFAMILY,
                          fontWeight: FontWeight.w600,
                          color: greytheme500),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 80,
                    ),
                    flex: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(Icons.keyboard_arrow_right),
                  )
                ],
              )),
          // SizedBox(
          //   height: 10,
          // ),
          Divider(
            thickness: 2,
          ),
          // SizedBox(
          //   height: 10,
          // ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EnterMobileNoPage(
                          flag: 3,
                        )));
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 25, top: 10, bottom: 10),
                    child: Text(
                      'Update Mobile Number',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: KEY_FONTFAMILY,
                          fontWeight: FontWeight.w600,
                          color: greytheme500),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 80,
                    ),
                    flex: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(Icons.keyboard_arrow_right),
                  )
                ],
              )),
          Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              //  final action = await DailogBox.settingDialog(context,'Delete Account?','Are you sure you want to delete your account?' 'Yes', 'No');
              final action = await DailogBox.settingDialog(
                  context,
                  'Delete Account?',
                  'Are you sure you want to delete your account?',
                  'Yes',
                  'No');
              if (action == DailogAction.yes) {
                deleteAccPresenter.deleteAccRequest(context);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: 25, bottom: 10),
              child: Text(
                'Delete Account',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w600,
                    color: greytheme500),
              ),
            ),
          ),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }

  void showAlertSuccess(String title, String message, BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(
                  StringUtils.capitalize(title),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FONTSIZE_18,
                      fontFamily: KEY_FONTFAMILY,
                      fontWeight: FontWeight.w600,
                      color: greytheme700),
                ),
                content:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Image.asset(
                    SUCCESS_IMAGE_PATH,
                    width: 75,
                    height: 75,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    StringUtils.capitalize(message),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: FONTSIZE_15,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w500,
                        color: greytheme700),
                  )
                ]),
                actions: <Widget>[
                  Divider(
                    endIndent: 15,
                    indent: 15,
                    color: Colors.black,
                  ),
                  FlatButton(
                    child: Text(STR_OK,
                        style: TextStyle(
                            fontSize: FONTSIZE_16,
                            fontFamily: KEY_FONTFAMILY,
                            fontWeight: FontWeight.w600,
                            color: greytheme700)),
                    onPressed: () {
                      Navigator.of(context).pop();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                          ModalRoute.withName("/loginView"));
                    },
                  )
                ],
              ),
            ));
  }

  @override
  void deleteAccFailed() {}

  @override
  void deleteAccSuccess(String message) {
    showAlertSuccess("Account Status", message, context);
  }
}
