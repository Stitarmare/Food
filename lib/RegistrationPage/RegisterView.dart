import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/Otp/OtpView.dart';
import 'dart:math' as math;
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';
import 'package:foodzi/RegistrationPage/RegisterPresenter.dart';
import 'package:foodzi/widgets/WebView.dart';
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
  bool isSelected = false;
  String strWebViewUrl = "";

  bool _validate = false;
  var countrycode = "";

  final Map<String, dynamic> _signUpData = {
    mobno: null,
    enterPass: null,
    name: null,
  };
  var registerPresenter;
  @override
  void initState() {
    registerPresenter = RegisterPresenter(this);
    strWebViewUrl = BaseUrl.getBaseUrl() + STR_URL_TERMS_CONDITION_TITLE;

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

  Future<void> onSignUpButtonClicked() async {
    if (_signUpFormKey.currentState.validate()) {
      await progressDialog.show();
      //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
      registerPresenter.performregister(
          _firstname, _lastname, _phoneno, _password, countrycode, context);
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
                    height: 30,
                  ),
                  _buildTextField(),
                  SizedBox(
                    height: 30,
                  ),
                  _termsConditionText(),
                  SizedBox(
                    height: 10,
                  ),
                  _signUpButton(),
                  SizedBox(
                    height: 45,
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

  Widget _termsConditionText() {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          title: new Text("I agree to the terms and conditions"),
          value: isSelected,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool value) {
            setState(() {
              isSelected = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WebViewPage(
                        title: STR_TERMS_CONDITION,
                        strURL: strWebViewUrl,
                        flag: 2,
                      ),
                    ));
              },
              child: Text(
                "Terms & Condition",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildImagelogo() {
    return Column(
      children: <Widget>[
        Image.asset(FOODZI_LOGO_PATH,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.15),
        SizedBox(height: 10),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: greentheme400,
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
          // inputFormatters: [
          //   LengthLimitingTextInputFormatter(20),
          //   BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
          // ],
          onChanged: (text) {
            _firstname = text;
          },
          keyboardType: TextInputType.text,
          icon: Icon(
            Icons.person,
            color: greentheme400,
          ),
          placeHolderName: KEY_FIRST_NAME,
          validator: validatFirstename,
          onSaved: (String value) {
            _signUpData[name] = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        AppTextField(
          // inputFormatters: [
          //   LengthLimitingTextInputFormatter(20),
          //   BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
          // ],
          onChanged: (text) {
            _lastname = text;
          },
          keyboardType: TextInputType.text,
          icon: Icon(
            Icons.person,
            color: greentheme400,
          ),
          placeHolderName: KEY_LAST_NAME,
          validator: validateLastname,
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
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: greentheme400),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: CountryCodePicker(
                onChanged: (text) {
                  countrycode = text.toString();
                },
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: '+27',
                favorite: ['+27', 'SA'],
                // optional. Shows only country name and flag
                showCountryOnly: false,
                // optional. Shows only country name and flag when popup is closed.
                showOnlyCountryWhenClosed: false,
                // optional. aligns the flag and the Text left
                alignLeft: false,
                onInit: (code) {
                  countrycode = code.dialCode;
                  print(countrycode);
                },
              ),
            ),
            //  AppTextField(
            //   inputFormatters: [
            //     LengthLimitingTextInputFormatter(4),
            //     BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
            //   ],
            //   icon: Icon(
            //     Icons.language,
            //     color: greentheme400,
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
                _phoneno = text;
              },
              keyboardType: TextInputType.phone,
              icon: Icon(Icons.call, color: greentheme400),
              placeHolderName: KEY_MOBILE_NUMBER,
              validator: validatemobno,
              onSaved: (String value) {
                _signUpData[mobno] = value;
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
              child: Icon(Icons.vpn_key, color: greentheme400),
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

  String validatFirstename(String value) {
    String validCharacters = STR_VALIDATE_NAME_TITLE;
    RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return STR_FIRST_NAME_REQUIRED;
    } else if (value.length > 20) {
      return KEY_THIS_SHOULD_BE_ONLY_20_CHAR_LONG;
    } else if (!regexp.hasMatch(value)) {
      return Key_SPECIAL_CHAR;
    }
    return null;
  }

  String validateLastname(String value) {
    String validCharacters = STR_VALIDATE_NAME_TITLE;
    RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return STR_LAST_NAME_REQUIRED;
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
      return KEY_MOBILE_NUMBER_REQUIRED;
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
        color: isSelected ? greentheme400 : greytheme100,
        onPressed: () => isSelected ? onSignUpButtonClicked() : null,
        child: Text(
          KEY_SIGN_UP,
          style: TextStyle(
              fontSize: FONTSIZE_16,
              fontWeight: FontWeight.w600,
              fontFamily: Constants.getFontType()),
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
                fontFamily: Constants.getFontType(),
                fontWeight: FontWeight.w600,
                color: greytheme100,
                fontSize: FONTSIZE_16),
          ),
          SizedBox(
            width: 3,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: new Text(
              KEY_SIGNIN,
              style: TextStyle(
                  color: greentheme400,
                  fontWeight: FontWeight.w600,
                  fontFamily: Constants.getFontType(),
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
        countryCode: countrycode,
        value: 0,
      );
    }));
  }

  @override
  Future<void> registerSuccess() async {
    _signUpFormKey.currentState.save();
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    _goToNextPageDineIn(context);
  }

  @override
  Future<void> registerfailed() async {
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }
}
