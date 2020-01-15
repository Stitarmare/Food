import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';

class RestaurantView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RestaurantViewState();
  }
}

class _RestaurantViewState extends State<RestaurantView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.perm_identity),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _buildMainView(),
      ),
    );
  }

  Widget _buildMainView() {
    return Container(
      child: Column(
        children: <Widget>[
          _getmainviewTableno(),
          SizedBox(
            height: 40,
          ),
          _getOptionscollections()
        ],
      ),
    );
  }

  Widget _getmainviewTableno() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 40,
                ),
                Text(
                  'That’s Amore',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              //endIndent: 10,
              //indent: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 26,
                ),
                Image.asset('assets/DineInImage/Group1504.png'),
                SizedBox(
                  width: 20,
                ),
                Text('Dine-in')
              ],
            ),
            Row(
              children: <Widget>[SizedBox(width: 76), Text('Add Table Number')],
            )
          ],
        ),
      ),
    );
  }

  Widget _getOptionscollections() {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                height: 22,
                // width: 100,
                child: new OutlineButton(
                    child: new Text("Breakfast"),
                    onPressed: null,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(2.0))),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 22,
                //   width: 80,
                child: new OutlineButton(
                    child: new Text("Lunch"),
                    onPressed: null,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(2.0))),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 22,
                //  width: 70,
                child: new OutlineButton(
                    child: new Text("Dinner"),
                    onPressed: null,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(2.0))),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 10),
              SizedBox(
                height: 22,
                child: new OutlineButton(
                    child: new Text("Deserts"),
                    onPressed: null,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(2.0))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
