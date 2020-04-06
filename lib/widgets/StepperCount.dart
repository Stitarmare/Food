import 'package:flutter/material.dart';
import 'package:foodzi/theme/colors.dart';

class StepperCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getmainview(),
    );
  }
}

Widget _getmainview() {
  return Row(children: <Widget>[
    InkWell(
      onTap: () {},
      splashColor: Colors.redAccent.shade200,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            Icons.remove,
            color: Colors.redAccent,
            size: 20,
          ),
        ),
      ),
    ),
    SizedBox(
      width: 4,
    ),
    Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('2'),
      ),
    ),
    SizedBox(
      width: 4,
    ),
    InkWell(
      onTap: () {},
      splashColor: Colors.lightBlue,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            Icons.add,
            color: greentheme,
            size: 20,
          ),
        ),
      ),
    )
  ]);
}
