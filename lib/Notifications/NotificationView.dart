import 'package:flutter/material.dart';
import 'package:foodzi/LandingPage/LandingView.dart';
import 'package:foodzi/Models/NotificationModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Notifications/NotificationContarctor.dart';
import 'package:foodzi/Notifications/NotificationPresenter.dart';
import 'package:foodzi/Utils/ConstantImages.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/NotificationDailogBox.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';

enum NotificationType {
  order_item_status,
  updates_for_assigned_table,
  invitation,
  split_bill_request,
  app_update
}

class NotificationView extends StatefulWidget {
  var flag;
  NotificationView({Key key, this.flag}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotificationViewState();
  }
}

class _NotificationViewState extends State<NotificationView>
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
  ProgressDialog progressDialog;

  @override
  void initState() {
    notificationPresenter = NotificationPresenter(notificationModelView: this);
    // DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
    Globle().notificationFLag = false;
    notificationPresenter.updateNotification(context);
    notificationPresenter.getNotifications(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(STR_NOTIFICATION_TITLE,
              style: TextStyle(
                  color: greytheme1200,
                  fontSize: FONTSIZE_18,
                  fontFamily: Constants.getFontType(),
                  fontWeight: FontWeight.w500)),
          leading: IconButton(
            color: greytheme1200,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 22,
            ),
            onPressed: () {
              if (widget.flag == 1) {
                Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
              }
              Navigator.pop(context);
            },
          ),
        ),
        body: _notificationList(context));
  }

  int _selectedIndex = 0;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _notificationList(BuildContext context) {
    return getNotificationLength() == 0
        ? Container(
            child: Center(
              child: Text(STR_NO_NOTIFICATION,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FONTSIZE_22,
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.w500,
                      color: greytheme1200)),
            ),
          )
        : ListView.builder(
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
                            fontSize: FONTSIZE_15,
                            fontFamily: Constants.getFontType(),
                            color: greytheme1200),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 21),
                      child: Text(
                        getNotificationDate(index),
                        style: TextStyle(
                            fontSize: FONTSIZE_11,
                            fontFamily: Constants.getFontType(),
                            color: greytheme1400),
                      ),
                    ),
                    onTap: () {
                      _onTap(index, context);
                    },
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: greytheme1500),
                      gradient: LinearGradient(stops: [
                        0.015,
                        0.015
                      ], colors: [
                        _selectedIndex != null && _selectedIndex == index
                            ? greentheme400
                            : greytheme1500,
                        Colors.white
                      ])),
                ),
              );
            },
          );
  }

  _onTap(int index, context) async {
    _onSelected(index);
    print(notificationData[index].notifType);
    if (notificationData[index].notifType == STR_INVITATION) {
      if (notificationData[index].invitationStatus == null ||
          notificationData[index].invitationStatus.isEmpty) {
        notifytext = notificationData[index].notifText.split(STR_COMMA);
        recipientName = notifytext[0];
        recipientMobno = notifytext[1];
        tableno = notifytext[2];
        status = await DailogBox.notification_1(
            context, recipientName, recipientMobno,
            tableno: tableno);
        print(status);
        if (status == DailogAction.abort || status == DailogAction.yes) {
          var statusStr = "";
          if (status == DailogAction.abort) {
            statusStr = "reject";
          }
          if (status == DailogAction.yes) {
            statusStr = "accept";
          }
          await progressDialog.show();
          //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
          notificationPresenter.acceptInvitation(notificationData[index].fromId,
              notificationData[index].invitationId, statusStr, context);
        }
      }
    } else if (notificationData[index].notifType == STR_INVITE_REQUEST) {
      if (notificationData[index].invitationStatus == null ||
          notificationData[index].invitationStatus.isEmpty) {
        notifytext = notificationData[index].notifText.split(STR_COMMA);
        recipientName = notifytext[0];
        recipientMobno = notifytext[1];
        tableno = notifytext[2];
        status = await DailogBox.notification_1(
            context, recipientName, recipientMobno,
            tableno: tableno);
        print(status);
        if (status == DailogAction.abort || status == DailogAction.yes) {
          var statusStr = "";
          if (status == DailogAction.abort) {
            statusStr = "reject";
          }
          if (status == DailogAction.yes) {
            statusStr = "accept";
          }
          await progressDialog.show();
          //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
          notificationPresenter.acceptRequestInvitiation(
              notificationData[index].fromId,
              notificationData[index].invitationId,
              statusStr,
              context);
        }
      }
    } else if (notificationData[index].notifType == null) {
      if (notificationData[index].invitationStatus == null ||
          notificationData[index].invitationStatus.isEmpty) {
        notifytext = notificationData[index].notifText.split(STR_COMMA);
        recipientName = notifytext[0];
        recipientMobno = notifytext[1];
        // tableno = notifytext[2];
        status = await DailogBox.notification_1(
            context, recipientName, recipientMobno);
        print(status);
        if (status == DailogAction.abort || status == DailogAction.yes) {
          var statusStr = "";
          if (status == DailogAction.abort) {
            statusStr = "reject";
          }
          if (status == DailogAction.yes) {
            statusStr = "accept";
          }
          if (statusStr == "accept") {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainWidget()),
                ModalRoute.withName("/MainWidget"));
          }
        }
      }
    }
  }

  int getNotificationLength() {
    if (notificationData != null) {
      return notificationData.length;
    }
    return 0;
  }

  String getNotificationText(int index) {
    if (notificationData != null) {
      if (notificationData[index].notifText != null) {
        if (notificationData[index].notifType == STR_INVITATION) {
          notifytext = notificationData[index].notifText.split(STR_COMMA);
          recipientName = notifytext[0];
          recipientMobno = notifytext[1];
          tableno = notifytext[2];
          print(recipientName);
          print(tableno);
        }
        return notificationData[index].notifText.toString();
      }
      return STR_NO_NOTIFI_TITLE;
    }
    return STR_SPACE;
  }

  @override
  void getNotificationsFailed() {}

  @override
  Future<void> getNotificationsSuccess(List<Datum> getNotificationList) async {
    if (getNotificationList.length == 0) {
      return;
    }
    setState(() {
      if (notificationData == null) {
        notificationData = getNotificationList;
      } else {
        // notificationData.addAll(getNotificationList);
        notificationData = getNotificationList;
      }
      page++;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  String getNotificationDate(int index) {
    if (notificationData != null) {
      if (notificationData[index].createdAt != null) {
        return getDateForOrderHistory(
            notificationData[index].createdAt.toString());
      }
      return STR_SPACE;
    }
    return STR_SPACE;
  }

  String getDateForOrderHistory(String dateString) {
    var date = DateTime.parse(dateString);
    var dateStr = DateFormat("dd MMM yyyy").format(date.toLocal());

    DateFormat format = new DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime time1 = format.parse(dateString, true);
    var time = DateFormat("hh:mm a").format(time1.toLocal());

    return "$dateStr at $time";
  }

  @override
  Future<void> acceptInvitationFailed(ErrorModel model) async {
    await progressDialog.hide();
    // Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    if (model != null) {
      notificationPresenter.getNotifications(context);

      Toast.show(
        model.message,
        Globle().context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
      );
    }
  }

  @override
  Future<void> acceptInvitationSuccess(ErrorModel model) async {
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    if (model != null) {
      notificationPresenter.getNotifications(context);
      Toast.show(
        model.message,
        Globle().context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
      );
    }
  }

  @override
  void updateNotificationFailed() {}

  @override
  void updateNotificationSuccess(String message) {}

  @override
  void acceptRejectFailed(ErrorModel model) async {
    await progressDialog.hide();

    if (model != null) {
      notificationPresenter.getNotifications(context);
      Toast.show(
        model.message,
        Globle().context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
      );
    }
  }

  @override
  void acceptRejectSuccess(ErrorModel model) async {
    await progressDialog.hide();

    if (model != null) {
      notificationPresenter.getNotifications(context);
      Toast.show(
        model.message,
        Globle().context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
      );
    }
  }
}
