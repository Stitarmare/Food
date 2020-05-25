import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/EnterMobileNoOTP/EnterOtp.dart';
import 'package:foodzi/Login/LoginContractor.dart';
import 'package:foodzi/Models/EditCityModel.dart';
import 'dart:math' as math;
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';
import 'LoginPresenter.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
  var mobilenumber = STR_BLANK;
  var countrycoder = STR_BLANK;
  var password = STR_BLANK;
  var countrycode = "+91";
  bool _validate = false;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  ProgressDialog progressDialog;
  LoginPresenter loginPresenter;
  @override
  void initState() {
    loginPresenter = LoginPresenter(this);
    super.initState();
  }

  final Map<String, dynamic> _signInData = {
    mobno: null,
    enterPass: null,
  };
  @override
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

  Future<void> onSignInButtonClicked() async {
    if (_signInFormKey.currentState.validate()) {
      await progressDialog.show();
      //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
      loginPresenter.performLogin(mobilenumber, countrycode, password, context);
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
                    height: 60,
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
        Center(
            child: Image.asset(FOODZI_LOGO_PATH,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.15)),
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

  Widget _buildTextField() {
    const pi = 3.14;
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: greentheme100),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: CountryCodePicker(
                  onChanged: (text) {
                    countrycode = text.toString();
                  },
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: '+91',
                  favorite: ['+91', 'IN'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
              ),

              // AppTextField(
              //   inputFormatters: [
              //     LengthLimitingTextInputFormatter(4),
              //     BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
              //   ],
              //   icon: Icon(
              //     Icons.language,
              //     color: greentheme100,
              //   ),
              //   keyboardType: TextInputType.phone,
              //   placeHolderName: STR_CODE,
              //   onChanged: (text) {
              //     if (text.contains(STR_PLUS_SIGN)) {
              //       countrycode = text;
              //     } else {
              //       countrycode = STR_PLUS_SIGN + text;
              //     }
              //   },
              //   validator: validatecountrycode,
              // ),
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
          inputFormatters: [
            LengthLimitingTextInputFormatter(15),
            BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
          ],
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
          },
        ),
      ],
    );
  }

  String validatemobno(String value) {
    String pattern = STR_VALIDATE_MOB_NO;
    RegExp regExp = RegExp(pattern);
    // if (value.length == 0) {
    //   return KEY_MOBILE_NUMBER_REQUIRED;
    // } else if (!regExp.hasMatch(value)) {
    //   return KEY_MOBILE_NUMBER_TEXT;
    // } else if (value.length > 13) {
    //   return KEY_MOBILE_NUMBER_LIMIT;
    // }
    if (value.isEmpty) {
      return KEY_MOBILE_NUMBER_REQUIRED;
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

  String validatepassword(String value) {
    if (value.length == 0) {
      return KEY_PASSWORD_REQUIRED;
    }
    // else if (value.length < 8) {
    //   return KEY_THIS_SHOULD_BE_MIN_8_CHAR_LONG;
    // }
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
                  fontSize: FONTSIZE_12,
                  fontFamily: KEY_FONTFAMILY,
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
              fontSize: FONTSIZE_16,
              fontWeight: FontWeight.w700,
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
            fontSize: FONTSIZE_16,
            fontFamily: KEY_FONTFAMILY,
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
            STR_ACCOUNT,
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
              Navigator.pushNamed(context, STR_REGISTRATION_PAGE);
            },
            child: new Text(
              KEY_SIGNUP,
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

  @override
  Future<void> loginFailed() async {
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  Future<void> loginSuccess() async {
    _signInFormKey.currentState.save();
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
  }
}
