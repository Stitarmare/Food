import 'package:flutter/material.dart';
import 'package:foodzi/EnterMobileNoPage/EnterMobileNoPage.dart';
import 'package:foodzi/Setting/DeleteAccContractor.dart';
import 'package:foodzi/Setting/DeleteAccPresenter.dart';
import 'package:foodzi/Setting/NotificationSetting.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
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
    // TODO: implement initState
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
              fontFamily: Constants.getFontType(),
              fontWeight: FontWeight.w500,
              color: greytheme1200),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Image.asset(
              FOODZI_LOGO_PATH,
              height: 20,
            ),
          )
        ],
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
                          fontFamily: Constants.getFontType(),
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
                          fontFamily: Constants.getFontType(),
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
                    fontFamily: Constants.getFontType(),
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

  @override
  void deleteAccFailed() {
    // TODO: implement deleteAccFailed
  }

  @override
  void deleteAccSuccess() {
    // TODO: implement deleteAccSuccess
    Toast.show(
      'Account Deleted',
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
    );
  }
}
