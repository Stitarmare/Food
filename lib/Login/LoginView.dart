import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';
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
        body: Center(
      child: SingleChildScrollView(
        child: mainview(),
      ),
    ));
  }

  Widget mainview() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
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
    if (_signInFormKey.currentState.validate()) {
      _signInFormKey.currentState.save();
      Navigator.pushNamed(context, '/Landingview');
    } else {
      setState(() {
        _validate = true;
      });
    }
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
                  _buildImagelogo(),
                  SizedBox(
                    height: 60,
                  ),
                  _buildTextField(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 150, 0),
                  ),
                  _forgotpassword(),
                  SizedBox(
                    height: 27,
                  ),
                  _signinButton(),
                  SizedBox(
                    height: 20,
                  ),
                  _otptext(),
                  SizedBox(
                    height: 80,
                  ),
                  _signupbutton()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagelogo() {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/Logo/foodzi_logo.jpg',
          //height: 100,
        ),
        SizedBox(height: 10),
        Text('ORDER EASY',style: TextStyle(
              fontFamily: 'HelveticaNeue',
              fontSize: 11,
              color: greytheme400,
              fontWeight: FontWeight.w700,letterSpacing: 1),),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: Colors.green,
          indent: 145,
          endIndent: 145,
          height: 10,
          thickness: 3,
        )
      ],
    );
  }

  Widget _buildTextField() {
    const pi = 3.14;
    return Column(
      children: <Widget>[
        AppTextField(
          keyboardType: TextInputType.phone,
          icon: Icon(
            Icons.call,
            color: greentheme100,
          ),
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
              child: Icon(
                Icons.vpn_key,
                color: greentheme100,
              ),
            ),
          ),
          validator: validatepassword,
          onSaved: (String value) {
            _signInData[enterPass] = value;
            print('Details are : $_signInData');
          },
        ),
      ],
    );
  }

  String validatemobno(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return KEY_MOBILE_NUMBER_REQUIRED;
    } else if (!regExp.hasMatch(value)) {
      return KEY_MOBILE_NUMBER_TEXT;
    } else if (value.length != 10) {
      return KEY_MOBILE_NUMBER_LIMIT;
    }
    // if(value.trim().length <= 0){
    if (value.isEmpty) {
      return KEY_THIS_SHOULD_NOT_BE_EMPTY;
    }
    return null;
  }

  String validatepassword(String value) {
    if (value.length == 0) {
      return KEY_PASSWORD_REQUIRED;
    } else if (value.length != 8) {
      return KEY_THIS_SHOULD_BE_8_PLUS_CHAR_LONG;
    }
    return null;
  }

  Widget _forgotpassword() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //SizedBox(width: 170),
        ButtonTheme(
          minWidth: 8,
          height: 5,
          child: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/ResetPasswordview');
            },
            child: Text(
              KEY_FORGET_PASSWORD,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  color: greentheme100),
            ),
          ),
        )
      ],
    );
  }

  Widget _signinButton() {
    return ButtonTheme(
      minWidth: 280,
      height: 54,
      child: RaisedButton(
        color: greentheme100,
        onPressed: () => onSignInButtonClicked(),
        child: Text(
          KEY_SIGN_IN,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'gotham'),
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
        onPressed: () {
          Navigator.pushNamed(context, '/OTPScreen');
        },
        child: Text(
          KEY_OTP_SIGN_IN,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'gotham',
            fontWeight: FontWeight.w600,
            color: greentheme100,
          ),
        ),
      ),
    );
  }

  Widget _signupbutton() {
    return LimitedBox(
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(
                fontFamily: 'gotham',
                fontWeight: FontWeight.w600,
                color: greytheme100,
                fontSize: 16),
          ),
          SizedBox(
            width: 3,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/Registerview');
            },
            child: new Text(
              KEY_SIGNUP,
              style: TextStyle(
                  color: greentheme100,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'gotham',
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}