import 'package:flutter/material.dart';

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
        child: Icon(
          Icons.alarm,
          color: Colors.white,
          size: 30,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('data'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('data'),
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(widget.title),
        //Text('Dine-in', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, i) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 2),
            color: _selected[i]
                ? Colors.blue
                : null, // if current item is selected show blue color
            child: ListTile(
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
    children: <Widget>[
      Column(
        children: <Widget>[
          Text('That’s Amore'),
          SizedBox(
            height: 14,
          ),
          Row(
            children: <Widget>[Icon(Icons.alarm), Text('10:00 am - 10:30 pm')],
          )
        ],
      ),
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.my_location),
              Text('1.2 Miles'),
            ],
          ),
          Text('4.5')
        ],
      )
    ],
  );
}

class MyTabs {
  final String title;
  MyTabs({this.title});
}
