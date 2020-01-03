import 'package:flutter/material.dart';

import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';
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
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                Text(
                  'mobile number',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(height: 35),
            _mobnoEntered(),
            SizedBox(
              height: 10,
            ),
            _buidOTPtextinput(),
            SizedBox(
              height: 20,
            ),
            _resendOtp(),
            SizedBox(
              height: 25,
            ),
            _submitButton(),
            SizedBox(
              height: 50,
            ),
            _anothernumber()
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
        //padding: const EdgeInsets.all(40.0),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 42),

        child: PinCodeTextField(
          maxLength: 6,
          wrapAlignment: WrapAlignment.center,
          pinBoxWidth: 36.0,
          pinBoxHeight: 41.0,
          defaultBorderColor: Colors.grey[300],
          hasTextBorderColor: Colors.green,
          pinTextStyle: TextStyle(color: Colors.grey[600]),
          pinBoxRadius: 8.0,
          autofocus: false,
          onDone: (String value) {
            print(value);
          },
          pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 8.0),
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
    return Text('+91-12345 67890',
        style: TextStyle(
            color: greytheme300,
            fontFamily: 'gotham',
            fontWeight: FontWeight.w600,
            fontSize: 16));
  }

  Widget _submitButton() {
    return ButtonTheme(
      minWidth: 280,
      height: 54,
      child: RaisedButton(
        color: greentheme100,
        onPressed: () => onsubmitButtonClicked(),
        child: Text(
          KEY_SUBMIT_BUTTON,
          style: TextStyle(
              fontSize: 16, fontFamily: 'gotham', fontWeight: FontWeight.w600),
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

  Widget _anothernumber() {
    return LimitedBox(
      child: FlatButton(
          child: Text(
        KEY_PROVIDE_ANOTHER_NO,
        style: TextStyle(
            color: greentheme100,
            fontFamily: 'gotham',
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ), onPressed: () {
        Navigator.pushNamed(context, '/EnterOTPScreen');
      },),
    );
  }

  Widget _resendOtp() {
    return LimitedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Didn’t received the code?",
            style: TextStyle(
                fontFamily: 'gotham',
                fontWeight: FontWeight.w600,
                color: greytheme200,
                fontSize: 14),
          ),
          SizedBox(
            width: 3,
          ),
          new GestureDetector(
            onTap: () {
             // Navigator.pushNamed(context, '/Registerview');
             return showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: const Text("OTP Sent",
                textAlign: TextAlign.center,style: TextStyle(
                  color: greentheme100,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'gotham',
                  fontSize: 22),),
                content: Text('OTP has been successfully send to your mobile number.',textAlign: TextAlign.center,style: TextStyle(
                  color: greytheme100,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'gotham',
                  fontSize: 20),),
                actions: [
                 FlatButton(  
                  child: const Text("OK", style: TextStyle(
                  color: greentheme100,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'gotham',
                  fontSize: 20),),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
        );
            },
            child: new Text(
              'RESEND',
              style: TextStyle(
                  color: greytheme200,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'gotham',
                  fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}