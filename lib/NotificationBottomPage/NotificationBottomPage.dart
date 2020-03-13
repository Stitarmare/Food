import 'package:flutter/material.dart';
import 'package:foodzi/Models/NotificationModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Notifications/NotificationContarctor.dart';
import 'package:foodzi/Notifications/NotificationPresenter.dart';
import 'package:foodzi/Utils/dialogs.dart';
// import 'package:foodzi/widgets/DailogBox.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/NotificationDailogBox.dart';
import 'package:toast/toast.dart';

enum NotificationType{order_item_status,updates_for_assigned_table,invitation,split_bill_request,app_update }

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
  List<Datum> notificationData;
  int page = 1;
   var status;
 String recipientName;
 String recipientMobno;
 String tableno;
 List notifytext;
 final GlobalKey<State> _keyLoader = GlobalKey<State>();
  @override
  void initState() {
    // TODO: implement initState
    notificationPresenter = NotificationPresenter(notificationModelView: this);
     DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
    notificationPresenter.getNotifications(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
             brightness: Brightness.dark,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text("Notifications",
                style: TextStyle(
                    color: greytheme1200,
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
    return 
    getNotificationLength() == 0? Container(child: Center(child: Text("No Notifications!!",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w500,
                    color: greytheme1200)),),):
                    ListView.builder(
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
                      color: greytheme1200),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 21),
                child: Text(
                  // notificationData[index].createdAt ??
                  // '05 May 2019',
                  getNotificationDate(index),
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'gotham',
                      color: greytheme1400),
                ),
              ),
              onTap: ()  {
                // _onSelected(index);
                // if(notificationData[index].notifType == NotificationType.invitation ){
                //     // status = await DailogBox.notification_1(context);
                //     status = await DailogBox.notification_1(context, recipientName, recipientMobno, tableno);
                //     print(status);
                //     notificationPresenter.acceptInvitation(notificationData[index].fromId, notificationData[index].invitationId, status, context);
                //     //  notificationPresenter.acceptInvitation( notificationData[index].fromId,  notificationData[index],, rest_id, order_id, status, context)
                //     // notificationPresenter.acceptInvitation(notificationData[index].fromId, int.parse(tableno), rest_id, order_id, status, context);
                // }
                _onTap(index);
              },
            ),
            decoration: BoxDecoration(
                border: Border.all(color: greytheme1500),
                gradient: LinearGradient(stops: [
                  0.015,
                  0.015
                ], colors: [
                  _selectedIndex != null && _selectedIndex == index
                      ? greentheme100
                      : greytheme1500,
                  Colors.white
                ])),
          ),
        );
      },
    );
  }
_onTap(int index)async{
  _onSelected(index);
                print(notificationData[index].notifType);
                if(notificationData[index].notifType == "invitation" ){
                    // status = await DailogBox.notification_1(context);
                    status = await DailogBox.notification_1(context, recipientName, recipientMobno, tableno);
                    print(status);
                             DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
                    notificationPresenter.acceptInvitation(notificationData[index].fromId, notificationData[index].invitationId, status.toString(), context);
                    //  notificationPresenter.acceptInvitation( notificationData[index].fromId,  notificationData[index],, rest_id, order_id, status, context)
                    // notificationPresenter.acceptInvitation(notificationData[index].fromId, int.parse(tableno), rest_id, order_id, status, context);
                }
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
        if(notificationData[index].notifType == "invitation"){
       notifytext = notificationData[index].notifText.split(",");
       recipientName = notifytext[0];
       recipientMobno = notifytext[1];
       tableno = notifytext[3];
       print(recipientName);
       print(tableno);}
        return notificationData[index].notifText.toString();

      }
      return " No Notification";
    }
    return " ";

  }

  String getNotificationDate(int index){
    if(notificationData!= null){
      if(notificationData[index].createdAt != null){
        return notificationData[index].createdAt.toString();
      }
      return " ";
    }
    return " ";
  }

  @override
  void getNotificationsFailed() {
    // TODO: implement getNotificationsFailed
  }

  @override
  void getNotificationsSuccess(List<Datum> getNotificationList) {
     Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
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

  @override
  void acceptInvitationFailed(ErrorModel model) {
    // TODO: implement acceptInvitationFailed
     Toast.show(model.message, context, duration: Toast.LENGTH_SHORT, 
                      gravity:  Toast.BOTTOM,);
  }

  @override
  void acceptInvitationSuccess(ErrorModel model) {
    // TODO: implement acceptInvitationSuccess
     Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
     Toast.show(model.message, context, duration: Toast.LENGTH_SHORT, 
                      gravity:  Toast.BOTTOM,);
  }

  // @override
  // void acceptInvitationFailed() {
  //   // TODO: implement acceptInvitationFailed
  // }

  // @override
  // void acceptInvitationSuccess() {
  //   print('Invittationn accepted successfully');
  //   // TODO: implement acceptInvitationSuccess
  // }
}
