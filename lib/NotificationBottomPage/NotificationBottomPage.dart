import 'package:flutter/material.dart';
import 'package:foodzi/Models/NotificationModel.dart';
import 'package:foodzi/Notifications/NotificationContarctor.dart';
import 'package:foodzi/Notifications/NotificationPresenter.dart';
import 'package:foodzi/widgets/DailogBox.dart';
import 'package:foodzi/theme/colors.dart';

class BottomNotificationView extends StatefulWidget {
  BottomNotificationView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomNotificationViewState();
  }
}

class _BottomNotificationViewState extends State<BottomNotificationView>
    implements NotificationModelView {
  NotificationPresenter notificationPresenter;
  List<NotificationData> notificationData;
  int page = 1;
  final europeanCountries = [
    'Albania Does anyone know how to implement a selection of the elements located inside a ListView Class in Flutter. All elements present in my list are constructed as',
    'Andorra',
    'Armenia',
    'Austria',
    'Italy',
    'Kazakhstan',
    'Kosovo',
    'Latvia',
    'Liechtenstein',
    'Lithuania',
  ];
  @override
  void initState() {
    // TODO: implement initState
    notificationPresenter = NotificationPresenter(notificationModelView: this);
    notificationPresenter.getNotifications(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text("Notifications",
                style: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontSize: 18,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w500)),
          ),
          body: _notificationList(context)),
    );
  }

  int _selectedIndex = 0;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _notificationList(BuildContext context) {
    return ListView.builder(
      itemCount: getNotificationLength(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 17, left: 18, top: 10),
          child: Container(
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 8, right: 4, top: 7),
                child: Text(
                  getNotificationText(index),
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'gotham',
                      color: Color.fromRGBO(51, 51, 51, 1)),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 21),
                child: Text(
                  notificationData[index].createdAt ??
                  '05 May 2019',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'gotham',
                      color: Color.fromRGBO(152, 152, 152, 1)),
                ),
              ),
              onTap: () async {
                _onSelected(index);
                await DailogBox.notification_1(context);
              },
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(112, 112, 112, 0.2)),
                gradient: LinearGradient(stops: [
                  0.015,
                  0.015
                ], colors: [
                  _selectedIndex != null && _selectedIndex == index
                      ? greentheme100
                      : Color.fromRGBO(112, 112, 112, 0.2),
                  Colors.white
                ])),
          ),
        );
      },
    );
  }
  int getNotificationLength() {
    if (notificationData != null) {
      return notificationData.length;
    }
    return 0;
  }
  String getNotificationText(int index){
    if(notificationData != null){
      if(notificationData[index].notifText !=null){
        return notificationData[index].notifText.toString();

      }
      return " No Notification";
    }
    return " ";

  }
  @override
  void getNotificationsFailed() {
    // TODO: implement getNotificationsFailed
  }

  @override
  void getNotificationsSuccess(List<NotificationData> getNotificationList) {
    // TODO: implement getNotificationsSuccess
          if (getNotificationList.length == 0) {
      return;
    }
    setState(() {
      if (notificationData == null) {
        notificationData = getNotificationList;
      } else {
       // notificationData.removeRange(0, (notificationData.length));
        notificationData.addAll(getNotificationList);
      }
      page++;
    });
  }
}
