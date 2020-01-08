import 'package:flutter/material.dart';

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.perm_identity),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _getmainviewTableno(),
      ),
    );
  }

  Widget _getmainviewTableno() {
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            Text('That’s Amore'),
            Divider(
              endIndent: 10,
              indent: 10,
            ),
            Row(
              children: <Widget>[
                Image.asset('assets/DineInImage/Group1504.png'),
                SizedBox(
                  width: 20,
                ),
                Text('Dine-in')
              ],
            ),
            Text('Add Table Number')
          ],
        ),
      ),
    );
  }

  Widget _getOptionscollections() {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ButtonTheme(
                buttonColor: Colors.transparent,
                child: RaisedButton(
                  child: Text('data'),
                  onPressed: () {},
                  color: Colors.transparent,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
