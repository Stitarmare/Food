import 'package:flutter/material.dart';
import 'package:foodzi/theme/colors.dart';

class DineInView extends StatefulWidget {
  String title;
  DineInView({this.title});
  @override
  State<StatefulWidget> createState() {
    return _DineViewState();
  }
}

class _DineViewState extends State<DineInView> {
  List<bool> _selected = List.generate(20, (i) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 60,
        height: 60,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: orangetheme,
              onPressed: () {},
              child: Image.asset('assets/ClockIcon/clock.png')),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Image.asset('assets/HomeIcon/home(2).png'),
            title: Text('Home')),
        BottomNavigationBarItem(
            icon: Image.asset('assets/OrderIcon/order.png'),
            title: Text('Order')),
        BottomNavigationBarItem(
            icon: Image.asset('assets/NotificationIcon/Path1159.png'),
            title: Text('Path')),
        BottomNavigationBarItem(
            icon: Image.asset('assets/UserIcon/Group3.png'),
            title: Text('User')),
      ]),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w500,
                color: greytheme1200),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/LevelsIcon/levels.png'),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, i) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
              //side: BorderSide(color: Colors.red)
            ),
            elevation: 2,
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 14),
            color: _selected[i]
                ? Colors.blue
                : null, // if current item is selected show blue color
            child: ListTile(
              contentPadding: EdgeInsets.all(0.0),
              title: _getMainView(
                  "merchantName", "location", "shortdatetime", "rating"),
              onTap: () => setState(
                  () => _selected[i] = !_selected[i]), // reverse bool value
            ),
          );
        },
      ),
    );
  }

  Widget _getMainView(String merchantName, String location,
      String shortdatetime, String rating) {
    return Column(
      children: <Widget>[
        Card(
          child: Container(
            height: 118,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/HotelImages/Image12.png'),
                  fit: BoxFit.fitWidth),
            ),
          ),
        ),
        _getdetails(merchantName, location, shortdatetime, rating)
      ],
    );
  }
}

Widget _getdetails(
    String merchantName, String location, String shortdatetime, String rating) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 11.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'That’s Amore',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: 'gotham',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: greytheme700),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.watch_later,
                  color: Colors.green,
                  size: 15,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '10:00 am - 10:30 pm',
                  style: TextStyle(
                      fontFamily: 'gotham',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: greytheme100),
                )
              ],
            ),
          ),
          SizedBox(
            height: 13,
          )
        ],
      ),
      Expanded(
        child: Container(),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: greentheme100,
                  size: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '1.2 Miles',
                  style: TextStyle(
                      fontFamily: 'gotham',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: greytheme100),
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              color: greentheme100,
              width: 30,
              height: 16,
              child: Center(
                child: Text(
                  '4.5',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'gotham',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 13,
            )
          ],
        ),
      )
    ],
  );
}
