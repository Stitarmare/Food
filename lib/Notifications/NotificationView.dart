import 'package:flutter/material.dart';
import 'package:foodzi/theme/colors.dart';

class NotificationView extends StatefulWidget {
  NotificationView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotificationViewState();
  }
}
class ListItem<T>{
  bool isSelected = false;
   T data;
   ListItem(this.data);
}

class _NotificationViewState extends State<NotificationView> {
  
  final europeanCountries = ['Albania Does anyone know how to implement a selection of the elements located inside a ListView Class in Flutter. All elements present in my list are constructed as', 'Andorra', 'Armenia', 'Austria',
        'Italy', 'Kazakhstan', 'Kosovo', 'Latvia', 'Liechtenstein', 'Lithuania',];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text("Notifications",
              style: TextStyle(
                  color: Color.fromRGBO(51, 51, 51, 1),
                  fontSize: 18,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w500)),
          leading: IconButton(
            color: Color.fromRGBO(51, 51, 51, 1),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 22,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _notificationList(context));
  }

  Widget _notificationList(BuildContext context) {
    // bool isSelected = false;
    List<int> _list = List.generate(europeanCountries.length, (i) => i);
List<bool> _selected = List.generate(europeanCountries.length, (i) => false);
    return ListView.builder(
      itemCount: europeanCountries.length,
      itemBuilder: (BuildContext context, int index) {
        return  Padding(
            padding: const EdgeInsets.only(right: 17,left: 18,top: 10),
            child: Container(
             child:
              ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 8,right: 4,top: 7),
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
                    onTap: () {
                     setState(() {
                       _selected[index] = !_selected[index];
                     });
                    },
                  ),
                  decoration: BoxDecoration(
                    // border: Border.all(),
                    border: Border.all(color: Color.fromRGBO(112, 112, 112, 0.2)),
                    gradient: LinearGradient(
                      stops:[0.015,0.015],
                      colors: [
                        _selected[index] ? Color.fromRGBO(55, 180, 76, 1):Color.fromRGBO(112, 112, 112, 0.2),
                        Colors.white
                        ]
                    )
                  ),
                ), 
        );
      },
    );
  }
}
