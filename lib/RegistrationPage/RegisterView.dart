import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/Otp/OtpView.dart';
import 'dart:math' as math;
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';
import 'package:foodzi/RegistrationPage/RegisterPresenter.dart';
import 'RegisterContractor.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Registerview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterviewState();
  }
}

class _RegisterviewState extends State<Registerview>
    implements RegisterModelView {
  static String mobno = KEY_MOBILE_NUMBER;
  static String enterPass = KEY_ENTER_PASSWORD;
  static String name = Key_USER_NAME;
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  ProgressDialog progressDialog;

  bool _validate = false;
  var countrycode = STR_BLANK;

  final Map<String, dynamic> _signUpData = {
    mobno: null,
    enterPass: null,
    name: null,
  };
  var registerPresenter;
  @override
  void initState() {
    registerPresenter = RegisterPresenter(this);
    super.initState();
  }

  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
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
      progressDialog.show();
      //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
      registerPresenter.performregister(
          _firstname, _lastname, _phoneno, _password, context);
      _signUpFormKey.currentState.save();
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
                    height: 112,
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
          FOODZI_LOGO_PATH,
        ),
        SizedBox(height: 10),
        // Text(
        //   STR_ORDER_EASY,
        //   style: TextStyle(
        //       fontFamily: KEY_FONT_HELVETICANEUE,
        //       fontSize: FONTSIZE_11,
        //       color: greytheme400,
        //       fontWeight: FontWeight.w700,
        //       letterSpacing: 1),
        // ),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: greentheme,
          indent: 138,
          endIndent: 135,
          height: 10,
          thickness: 3,
        )
      ],
    );
  }

  var _firstname = STR_BLANK;
  var _lastname = STR_BLANK;
  var _phoneno = STR_BLANK;
  var _password = STR_BLANK;

  Widget _buildTextField() {
    const pi = 3.14;
    return Column(
      children: <Widget>[
        AppTextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
            BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
          ],
          onChanged: (text) {
            _firstname = text;
          },
          keyboardType: TextInputType.text,
          icon: Icon(
            Icons.person,
            color: greentheme100,
          ),
          placeHolderName: KEY_FIRST_NAME,
          validator: validatename,
          onSaved: (String value) {
            _signUpData[name] = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        AppTextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
            BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
          ],
          onChanged: (text) {
            _lastname = text;
          },
          keyboardType: TextInputType.text,
          icon: Icon(
            Icons.person,
            color: greentheme100,
          ),
          placeHolderName: KEY_LAST_NAME,
          validator: validatename,
          onSaved: (String value) {
            _signUpData[name] = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        Row(children: <Widget>[
          Expanded(
            flex: 2,
            child: AppTextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
                BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
              ],
              icon: Icon(
                Icons.language,
                color: greentheme100,
              ),
              keyboardType: TextInputType.phone,
              placeHolderName: STR_CODE,
              onChanged: (text) {
                if (text.contains(STR_PLUS_SIGN)) {
                  countrycode = text;
                } else {
                  countrycode = STR_PLUS_SIGN + text;
                }
              },
              validator: validatecountrycode,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: AppTextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT)),
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onChanged: (text) {
                _phoneno = countrycode + text;
              },
              keyboardType: TextInputType.phone,
              icon: Icon(Icons.call, color: greentheme100),
              placeHolderName: KEY_MOBILE_NUMBER,
              validator: validatemobno,
              onSaved: (String value) {
                _signUpData[mobno] = countrycode + value;
              },
            ),
          )
        ]),
        SizedBox(height: 15),
        AppTextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(15),
            BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
          ],
          onChanged: (text) {
            _password = text;
          },
          obscureText: true,
          placeHolderName: KEY_ENTER_PASSWORD,
          icon: Transform.rotate(
            angle: 360 * pi / 95,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Icon(Icons.vpn_key, color: greentheme100),
            ),
          ),
          validator: validatepassword,
          onSaved: (String value) {
            _signUpData[enterPass] = value;
            print(STR_DETAILS_ARE + '$_signUpData');
          },
        ),
      ],
    );
  }

  String validatename(String value) {
    String validCharacters = STR_VALIDATE_NAME_TITLE;
    RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return KEY_THIS_SHOULD_NOT_BE_EMPTY;
    } else if (value.length > 20) {
      return KEY_THIS_SHOULD_BE_ONLY_20_CHAR_LONG;
    } else if (!regexp.hasMatch(value)) {
      return Key_SPECIAL_CHAR;
    }
    return null;
  }

  String validatemobno(String value) {
    String pattern = STR_VALIDATE_MOB_NO;
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return KEY_MOBILE_NUMBER_REQUIRED;
    } else if (!regExp.hasMatch(value)) {
      return KEY_MOBILE_NUMBER_TEXT;
    } else if (value.length > 13) {
      return KEY_MOBILE_NUMBER_LIMIT;
    }
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

  String validatecountrycode(String value) {
    String pattern = STR_VALIDATE_COUNTRY_CODE;
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return KEY_COUNTRYCODE_REQUIRED;
    } else if (value.length > 4) {
      return KEY_COUNTRY_CODE_LIMIT;
    } else if (!value.startsWith(STR_PLUS_SIGN)) {
      if (!regExp.hasMatch(value)) {
        return KEY_COUNTRY_CODE_TEXT;
      }
    }
    return null;
  }

  Widget _signUpButton() {
    return ButtonTheme(
      minWidth: 280,
      height: 54,
      child: RaisedButton(
        color: greentheme100,
        onPressed: () => onSignUpButtonClicked(),
        child: Text(
          KEY_SIGN_UP,
          style: TextStyle(
              fontSize: FONTSIZE_16,
              fontWeight: FontWeight.w600,
              fontFamily: KEY_FONTFAMILY),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            STR_ALREADY_ACCOUNT,
            style: TextStyle(
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w600,
                color: greytheme100,
                fontSize: FONTSIZE_16),
          ),
          SizedBox(
            width: 3,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, STR_LOGIN_PAGE);
            },
            child: new Text(
              KEY_SIGNIN,
              style: TextStyle(
                  color: greentheme100,
                  fontWeight: FontWeight.w600,
                  fontFamily: KEY_FONTFAMILY,
                  fontSize: FONTSIZE_16),
            ),
          )
        ],
      ),
    );
  }

  _goToNextPageDineIn(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OTPScreen(
        mobno: _phoneno,
        value: 0,
      );
    }));
  }

  @override
  void registerSuccess() {
    _signUpFormKey.currentState.save();
    progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    _goToNextPageDineIn(context);
  }

  @override
  void registerfailed() {
    progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }
}
