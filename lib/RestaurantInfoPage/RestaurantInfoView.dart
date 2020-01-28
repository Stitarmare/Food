import 'package:flutter/material.dart';

class RestaurantInfoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RestaurantInfoViewState();
  }
}

class _RestaurantInfoViewState extends State<RestaurantInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: _buildMainListview(),
        ),
      ),
    );
  }

  Widget _buildMainListview() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Image.asset('name'),
        )
      ],
    );
  }
}
