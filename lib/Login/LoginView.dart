import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/EnterMobileNoOTP/EnterOtp.dart';
import 'package:foodzi/Login/LoginContractor.dart';

import 'dart:math' as math;

import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
//import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';

import 'LoginPresenter.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> implements LoginModelView {
  static String mobno = KEY_MOBILE_NUMBER;
  static String enterPass = KEY_ENTER_PASSWORD;

  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  var name;
  var mobilenumber = '';
  var password = '';
  bool _validate = false;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  Dialogs dialogs = Dialogs();
  var loginPresenter;
  @override
  void initState() {
    // TODO: implement initState
    loginPresenter = LoginPresenter(this);
    super.initState();
  }

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
      Dialogs.showLoadingDialog(context, _keyLoader, "");
      loginPresenter.performLogin(mobilenumber, password, context);
      // _signInFormKey.currentState.save();
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
        Text(
          'ORDER EASY',
          style: TextStyle(
              fontFamily: 'HelveticaNeue',
              fontSize: 11,
              color: greytheme400,
              fontWeight: FontWeight.w700,
              letterSpacing: 1),
        ),
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
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: AppTextField(
                icon: Icon(Icons.flag),
                keyboardType: TextInputType.phone,
                placeHolderName: "Code",
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: AppTextField(
                onChanged: (text) {
                  mobilenumber = text;
                },
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
            ),
          ],
        ),
        SizedBox(height: 15),
        AppTextField(
          onChanged: (text) {
            password = text;
          },
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
    } else if (value.length < 8) {
      return KEY_THIS_SHOULD_BE_MIN_8_CHAR_LONG;
    }
    return null;
  }

  Widget _forgotpassword() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        ButtonTheme(
          minWidth: 8,
          height: 5,
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EnterOTPScreen(
                            flag: 1,
                          )));
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => EnterOTPScreen(
                    flag: 2,
                  )));
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
              Navigator.pushReplacementNamed(context, '/Registerview');
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

  @override
  void loginFailed() {
    // TODO: implement loginFailed
    print("pop f close");
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void loginSuccess() {
    // TODO: implement loginSuccess
    _signInFormKey.currentState.save();
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    Navigator.pushReplacementNamed(context, '/MainWidget');
  }
}
