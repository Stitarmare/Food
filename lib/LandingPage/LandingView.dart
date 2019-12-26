import 'package:flutter/material.dart';

class Landingview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingStateView();
  }
}

class _LandingStateView extends State<Landingview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(icon: new Icon(Icons.settings), onPressed: () {}
            // _scaffoldKey.currentState.openDrawer()
            /// backgroundColor: Colors.blue,
            // title: Text('data'),
            ),
      ),
      body: _getmainView(),
    );
  }
}

Widget _getmainView() {
  return LimitedBox(
    child: Container(
      child: Column(
        children: <Widget>[_buildimage()],
      ),
    ),
  );
}

Widget _buildimage() {
  return Image.asset('assets/LandingImage/Group1561.png');
}
