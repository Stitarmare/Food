import 'package:flutter/material.dart';

import 'package:foodzi/Utils/String.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
//import 'package:foodzi/widgets/AppTextfield.dart';

class OTPScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OTPScreenState();
  }
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white70,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: mainview(),
          ),
        ));
  }

  Widget mainview() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[_buildStackView()],
      ),
    );
  }

  Widget _buildStackView() {
    return Stack(
      children: <Widget>[
        _buildmainview(),
      ],
    );
  }

  void onsubmitButtonClicked() {
    Navigator.pushNamed(context, '/EnterOTPScreen');
  }

  Widget _buildmainview() {
    return LimitedBox(
      child: Container(
        // margin: EdgeInsets.fromLTRB(15, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildImagelogo(),
            SizedBox(
              height: 30,
            ),
            Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                Text(
                  KEY_VERFICATION_OTP,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                Text(
                  'mobile number',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            SizedBox(height: 10),
            _mobnoEntered(),
            SizedBox(
              height: 15,
            ),
            _buidOTPtextinput(),
            SizedBox(
              height: 50,
            ),
            _submitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildImagelogo() {
    return Column(
      children: <Widget>[
        Image.asset('assets/PhoneImage/Group_295.png'
            //height: 100,
            ),
      ],
    );
  }

  Widget _buidOTPtextinput() {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: PinCodeTextField(
          wrapAlignment: WrapAlignment.center,
          pinBoxWidth: 35.0,
          pinBoxHeight: 41.0,
          defaultBorderColor: Colors.grey[300],
          hasTextBorderColor: Colors.green,
          pinTextStyle: TextStyle(color: Colors.grey[600]),
          pinBoxRadius: 8.0,
          autofocus: false,
          onDone: (String value) {
            print(value);
          },
          pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 15.0),
        ),
      ),
    );
  }

  String validatepassword(String value) {
    if (value.length == 0) {
      return KEY_PASSWORD_REQUIRED;
    } else if (value.length != 8) {
      return KEY_THIS_SHOULD_BE_8_PLUS_CHAR_LONG;
    }
    return null;
  }

  Widget _mobnoEntered() {
    return Text('+91-12345 67890');
  }

  Widget _submitButton() {
    return ButtonTheme(
      minWidth: 280,
      height: 54,
      child: RaisedButton(
        color: Color.fromRGBO(34, 180, 91, 0.80),
        onPressed: () => onsubmitButtonClicked(),
        child: Text(
          KEY_SUBMIT_BUTTON,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        textColor: Colors.white,
        textTheme: ButtonTextTheme.normal,
        splashColor: Color.fromRGBO(72, 189, 111, 0.80),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(32.0),
            side: BorderSide(color: Color.fromRGBO(72, 189, 111, 0.80))),
      ),
    );
  }
}
