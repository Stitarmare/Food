import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/widgets/AppTextfield.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  static String mobno = KEY_MOBILE_NUMBER;
  static String enterPass = KEY_ENTER_PASSWORD;

  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();

  bool _validate = false;

  final Map<String, dynamic> _signInData = {
    mobno: null,
    enterPass: null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: mainview(),
      ),
    );
  }

  Widget mainview() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 200, 30, 0),
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

  void onSignInButtonClicked() {
    _signInFormKey.currentState.save();
    if (_signInFormKey.currentState.validate()) {
      return;
    } else {
      setState(() {
        _validate = true;
      });
    }
    Navigator.pushReplacementNamed(context, '/HomePage');
  }

  Widget _buildmainview() {
    return LimitedBox(
      child: Container(
        child: Column(
          children: <Widget>[
            Form(
              key: _signInFormKey,
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  _buildTextField(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 150, 0),
                  ),
                  _forgotpassword(),
                  SizedBox(
                    height: 30,
                  ),
                  _signinButton(),
                  SizedBox(
                    height: 30,
                  ),
                  _otptext()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    const pi = 3.14;
    return Column(
      children: <Widget>[
        AppTextField(
          keyboardType: TextInputType.phone,
          icon: Icon(Icons.call),
          placeHolderName: KEY_MOBILE_NUMBER,
          validator: validatemobno,
          onSaved: (String value) {
            _signInData[mobno] = value;
          },
        ),
        SizedBox(height: 15),
        AppTextField(
          obscureText: true,
          placeHolderName: KEY_ENTER_PASSWORD,
          icon: Transform.rotate(
            angle: 360 * pi / 95,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Icon(Icons.vpn_key),
            ),
          ),
          validator: validatepassword,
          onSaved: (String value) {
            _signInData[enterPass] = value;
          },
        ),
      ],
    );
  }

  String validatemobno(String value) {
    // if(value.trim().length <= 0){
    if (value.isEmpty) {
      return KEY_THIS_SHOULD_NOT_BE_EMPTY;
    }
    return null;
  }

  String validatepassword(String value) {
    if (value.isEmpty) {
      return KEY_THIS_SHOULD_NOT_BE_EMPTY;
    } else if (enterPass == mobno && value.length < 8 ||
        value.trim().length <= 0) {
      return KEY_THIS_SHOULD_BE_8_PLUS_CHAR_LONG;
    }
    return null;
  }

  Widget _forgotpassword() {
    return Row(
      children: <Widget>[
        SizedBox(width: 170),
        ButtonTheme(
          minWidth: 8,
          height: 5,
          child: MaterialButton(
            onPressed: () {},
            child: Text(
              KEY_FORGET_PASSWORD,
              style: TextStyle(
                  fontSize: 15, color: Color.fromRGBO(72, 189, 111, 0.80)),
            ),
          ),
        )
      ],
    );
  }

  Widget _signinButton() {
    return ButtonTheme(
      minWidth: 350,
      height: 50,
      child: RaisedButton(
        color: Color.fromRGBO(34, 180, 91, 0.80),
        onPressed: () => onSignInButtonClicked(),
        child: Text(
          KEY_SIGN_IN,
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

  Widget _otptext() {
    return ButtonTheme(
      minWidth: 8,
      height: 5,
      child: MaterialButton(
        elevation: 0,
        onPressed: () {},
        child: Text(
          'Sign In using OTP',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(34, 180, 91, 0.80),
          ),
        ),
      ),
    );
  }

  // _sendToserver(){
  //   if(_signInFormKey.currentState.validate()){

  //   }else{
  //     setState(() {
  //       _validate = true;
  //     });
  //   }
  // }
}
