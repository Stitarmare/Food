import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/widgets/AppTextfield.dart';

class Registerview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterviewState();
  }
}

class _RegisterviewState extends State<Registerview> {
  static String mobno = KEY_MOBILE_NUMBER;
  static String enterPass = KEY_ENTER_PASSWORD;
  static String name = Key_USER_NAME;

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  bool _validate = false;

  final Map<String, dynamic> _signUpData = {
    mobno: null,
    enterPass: null,
    name: null,
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

  void onSignUpButtonClicked() {
    if (_signUpFormKey.currentState.validate()) {
      _signUpFormKey.currentState.save();
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
              key: _signUpFormKey,
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  _buildImagelogo(),
                  SizedBox(
                    height: 60,
                  ),
                  _buildTextField(),
                  SizedBox(
                    height: 50,
                  ),
                  _signUpButton(),
                  SizedBox(
                    height: 80,
                  ),
                  _signinbutton()
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
        Text('ORDER EASY'),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: Colors.green,
          indent: 140,
          endIndent: 140,
          height: 10,
          thickness: 4,
        )
      ],
    );
  }

  Widget _buildTextField() {
    const pi = 3.14;
    return Column(
      children: <Widget>[
        AppTextField(
          keyboardType: TextInputType.text,
          icon: Icon(Icons.person),
          placeHolderName: Key_USER_NAME,
          validator: validatename,
          onSaved: (String value) {
            _signUpData[name] = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        AppTextField(
          keyboardType: TextInputType.phone,
          icon: Icon(Icons.call),
          placeHolderName: KEY_MOBILE_NUMBER,
          validator: validatemobno,
          onSaved: (String value) {
            _signUpData[mobno] = value;
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
            _signUpData[enterPass] = value;
            print('Details are : $_signUpData');
          },
        ),
      ],
    );
  }

  String validatename(String value) {
    String validCharacters = r'^[a-zA-Z0-9]+$';
    RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return KEY_THIS_SHOULD_NOT_BE_EMPTY;
    } else if (value.length > 10) {
      return KEY_THIS_SHOULD_BE_ONLY_10_CHAR_LONG;
    } else if (!regexp.hasMatch(value)) {
      return Key_SPECIAL_CHAR;
    }
    return null;
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

  Widget _signUpButton() {
    return ButtonTheme(
      minWidth: 350,
      height: 50,
      child: RaisedButton(
        color: Color.fromRGBO(34, 180, 91, 0.80),
        onPressed: () => onSignUpButtonClicked(),
        child: Text(
          KEY_SIGN_UP,
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

  Widget _signinbutton() {
    return LimitedBox(
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Already have an Account?"),
          SizedBox(
            width: 3,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/LoginView');
            },
            child: new Text(
              KEY_SIGNIN,
              style: TextStyle(
                  color: Color.fromRGBO(34, 180, 91, 0.80),
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
