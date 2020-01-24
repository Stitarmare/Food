import 'package:flutter/material.dart';
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

class _BottomNotificationViewState extends State<BottomNotificationView> {
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
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Colors.white,
            //centerTitle: false,
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
      itemCount: europeanCountries.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 17, left: 18, top: 10),
          child: Container(
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 8, right: 4, top: 7),
                child: Text(
                  europeanCountries[index],
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'gotham',
                      color: Color.fromRGBO(51, 51, 51, 1)),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 21),
                child: Text(
                  '05 May 2019',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'gotham',
                      color: Color.fromRGBO(152, 152, 152, 1)),
                ),
              ),
              onTap: () async{
                _onSelected(index);
                await Dailogs.notification_1(context);
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
}
