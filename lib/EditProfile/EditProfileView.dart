import 'package:flutter/material.dart';
import 'package:foodzi/theme/colors.dart';
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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text("Edit Profile",
              style: TextStyle(
                  color: greytheme700,
                  fontSize: 18,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w500)),
        ),
        body: SingleChildScrollView(
          child: _getmainView(context),
        ));
  }
}

Widget _getmainView(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(30),
    child: Column(
      children: <Widget>[
        BoxAppTextField(
          placeHolderName: 'First Name',
        ),
        SizedBox(
          height: 28,
        ),
        BoxAppTextField(
          placeHolderName: 'Last Name',
        ),
        SizedBox(
          height: 28,
        ),
        BoxAppTextField(
          placeHolderName: 'Mobile Number',
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 28,
        ),
        BoxAppTextField(
          placeHolderName: 'Street',
        ),
        SizedBox(
          height: 28,
        ),
        
        BoxAppTextField(
          placeHolderName: 'Country',
        ),
        SizedBox(
          height: 28,
        ),
        BoxAppTextField(
          placeHolderName: 'State',
        ),
        SizedBox(
          height: 28,
        ),
        BoxAppTextField(
          placeHolderName: 'City',
        ),
        SizedBox(
          height: 28,
        ),
        BoxAppTextField(
          placeHolderName: 'Postal Code',
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 44,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.39,
              height: 43,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(6.0),
                ),
                color: greentheme100,
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'gotham',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {},
              ),
            ),
            // SizedBox(width:14,),
            Container(
              width: MediaQuery.of(context).size.width * 0.39,
              height: 43,
              child: RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0),
                    side: BorderSide(color: greytheme1100)),
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                      color: greytheme1000,
                      fontFamily: 'gotham',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {},
              ),
            )
          ],
        )
      ],
    ),
  );
}
