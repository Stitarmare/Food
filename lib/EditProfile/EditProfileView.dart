import 'package:flutter/material.dart';
import 'package:foodzi/widgets/BoxTextField.dart';

class EditProfileview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfileview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: _getmainView(),
    ));
  }
}

Widget _getmainView() {
  return Stack(
    children: <Widget>[
      BoxAppTextField(
        placeHolderName: 'data',
      )
    ],
  );
}
