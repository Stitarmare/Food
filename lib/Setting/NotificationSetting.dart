import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Setting/NotificationSettingPresenter.dart';
import 'package:foodzi/Utils/String.dart';
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
    // TODO: implement initState
    _notificationSettingPresenter =
        NotificationSettingPresenter(notificationSettingContractor: this);
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
                  value: (_switchvalue == true) ? true : checkBtn.isChecked,
                  onChanged: (val) {
                    setState(() {
                      checkBtn.isChecked = val;
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
  void onFailedUpdateNotification() {
    // TODO: implement onFailedUpdateNotification
  }

  @override
  void onSuccessUpdateNotification() {
    // TODO: implement onSuccessUpdateNotification
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
