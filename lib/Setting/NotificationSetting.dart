import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetNotificationSetting.dart';
import 'package:foodzi/Setting/NotificationSettingPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/theme/colors.dart';

class NotificationSetting extends StatefulWidget {
  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting>
    implements NotificationSettingContractor {
  bool _switchvalue = false;
  List<CheckBoxOptions> _checkBoxOptions = [
    CheckBoxOptions(
        index: 1, title: 'Activity on my Reviews', isChecked: false),
    CheckBoxOptions(
        index: 2, title: 'Important updates from Foodzi', isChecked: false),
    CheckBoxOptions(
        index: 3, title: 'Other social Notifications', isChecked: false)
  ];
  NotificationSettingPresenter _notificationSettingPresenter;

  @override
  void initState() {
    _notificationSettingPresenter =
        NotificationSettingPresenter(notificationSettingContractor: this);
    _notificationSettingPresenter.getNotificationSetting(context);
    Preference.getPrefValue<bool>("notificationKey").then((value) {
      if (value == true) {
        setState(() {
          this._switchvalue = value;
        });
      }
    });

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
          'Notification Settings',
          style: TextStyle(
              fontSize: FONTSIZE_18,
              fontFamily: Constants.getFontType(),
              fontWeight: FontWeight.w500,
              color: greytheme1200),
        ),
      ),
      body: SingleChildScrollView(
        // child: SliverToBoxAdapter(
        //           child: Container(
        //     margin: EdgeInsets.fromLTRB(0 ,10, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Enable All',
                    style: TextStyle(
                        fontSize: FONTSIZE_18,
                        fontFamily: Constants.getFontType(),
                        fontWeight: FontWeight.w400,
                        color: greytheme700),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 100,
                  ),
                  flex: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      // activeColor: ((Globle().colorscode) != null)
                      //     ? getColorByHex(Globle().colorscode)
                      //     : orangetheme,
                      onChanged: (bool value) {
                        setState(() {
                          this._switchvalue = value;
                          Preference.setPersistData<bool>(
                              value, "notificationKey");
                          _checkBoxOptions = [
    CheckBoxOptions(
        index: 1, title: 'Activity on my Reviews', isChecked: value),
    CheckBoxOptions(
        index: 2, title: 'Important updates from Foodzi', isChecked: value),
    CheckBoxOptions(
        index: 3, title: 'Other social Notifications', isChecked: value)
  ];
                        });
                        updateNotification();
                      },
                      value: this._switchvalue,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Push Notifications',
                style: TextStyle(
                    fontSize: FONTSIZE_18,
                    fontFamily: Constants.getFontType(),
                    fontWeight: FontWeight.w400,
                    color: greytheme700),
              ),
            ),
            _notificationCheckbox()
            // )
          ],
        ),
      ),
      // ),
      // ),
    );
  }

  Widget _notificationCheckbox() {
    return Column(
        children: _checkBoxOptions
            .map((checkBtn) => CheckboxListTile(
                  value: checkBtn.isChecked,
                  onChanged: (val) {
                    checkBtn.isChecked = val;
                    setState(() {
                      _checkBoxOptions[checkBtn.index-1].isChecked = val;
                      var check1 = false;
          var check2 = false;
          var check3 = false;
          
          if (_checkBoxOptions[0].isChecked){
              check1 = true;
          }
          if (_checkBoxOptions[1].isChecked){
            check2 = true;
          }
          if (_checkBoxOptions[2].isChecked){
            check3 = true;
          }

          if (check3 && check2 && check1) {
            this._switchvalue = true;
          } else {
            this._switchvalue = false;
          }
                    });
                    
                    updateNotification();
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    checkBtn.title,
                    style: TextStyle(fontSize: 16, color: greytheme1000),
                  ),
                ))
            .toList());
    // );
  }

  updateNotification() {
    List<int> notValue = [];

    for (var check in _checkBoxOptions) {
      if (check.isChecked) {
        notValue.add(check.index);
      }
    }

    _notificationSettingPresenter.callUpdateNotiApi(notValue, context);
  }

  @override
  void onFailedUpdateNotification() {}

  @override
  void onSuccessUpdateNotification() {}

  @override
  void onFailedGetNotification() {}

  @override
  void onSuccessGetNotification(GetNotificationSetting getNotificationSetting) {
    var model = getNotificationSetting.data;

    setState(() {
      if (model != null) {
        if (model.length > 0) {
          var check1 = false;
          var check2 = false;
          var check3 = false;
          for (var value in model) {
            if (value.notifType == "1") {
              _checkBoxOptions[0].isChecked = true;
              check1 = true;
            }
            if (value.notifType == "2") {
              _checkBoxOptions[1].isChecked = true;
              check2 = true;
            }
            if (value.notifType == "3") {
              _checkBoxOptions[2].isChecked = true;
              check3 = true;
            }
          }

          if (check3 && check2 && check1) {
            this._switchvalue = true;
          }
        }
      }
    });
  }
}

class CheckBoxOptions {
  int index;
  String title;
  // String price;
  bool isChecked;
  // String defaultAddition;

  CheckBoxOptions({
    this.index,
    this.title,
    // this.price,
    this.isChecked,
    // this.defaultAddition
  });
}
