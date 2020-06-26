import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/Otp/OtpView.dart';
import 'dart:math' as math;
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';

import 'package:progress_dialog/progress_dialog.dart';

class ChangeAddressView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangeAddressViewState();
  }
}

class _ChangeAddressViewState extends State<ChangeAddressView> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  ProgressDialog progressDialog;

  bool _validate = false;
  String strAddress = "";

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(STR_CHANGE_ADDRESS),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: mainview(),
        ));
  }

  Widget mainview() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
      strAddress = _address1 +
          ", " +
          _address2 +
          ", " +
          _city +
          ", " +
          _pincode +
          ", " +
          _state +
          ", " +
          _country;
      print(strAddress);
      Navigator.of(context).pop({"text": strAddress});
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
                  _buildTextField(),
                  SizedBox(
                    height: 50,
                  ),
                  _signUpButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  var _address1 = STR_BLANK;
  var _address2 = STR_BLANK;
  var _city = STR_BLANK;
  var _pincode = STR_BLANK;
  var _state = STR_BLANK;
  var _country = STR_BLANK;

  Widget _buildTextField() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        AppTextField(
          onChanged: (text) {
            _address1 = text;
          },
          keyboardType: TextInputType.text,
          placeHolderName: "Address 1",
          validator: validatename,
        ),
        SizedBox(
          height: 10,
        ),
        AppTextField(
          onChanged: (text) {
            _address2 = text;
          },
          keyboardType: TextInputType.text,
          placeHolderName: "Address 2",
          validator: validatename,
        ),
        SizedBox(
          height: 10,
        ),
        AppTextField(
          onChanged: (text) {
            _city = text;
          },
          keyboardType: TextInputType.text,
          placeHolderName: "City",
          validator: validateCity,
        ),
        SizedBox(
          height: 10,
        ),
        AppTextField(
          onChanged: (text) {
            _pincode = text;
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(4),
            WhitelistingTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
          placeHolderName: "ZIP / Postal Code",
          validator: validatePinCode,
        ),
        SizedBox(
          height: 10,
        ),
        AppTextField(
          onChanged: (text) {
            _state = text;
          },
          keyboardType: TextInputType.text,
          placeHolderName: "State",
          validator: validateState,
        ),
        SizedBox(
          height: 10,
        ),
        AppTextField(
          onChanged: (text) {
            _country = text;
          },
          keyboardType: TextInputType.text,
          placeHolderName: "Country",
          validator: validateCountry,
        ),
      ],
    );
  }

  String validatename(String value) {
    String validCharacters = STR_VALIDATE_NAME_TITLE;
    RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return STR_ADDRESS_REQUIRED;
    } else if (!regexp.hasMatch(value)) {
      return Key_SPECIAL_CHAR;
    }
    return null;
  }

  String validateCity(String value) {
    String validCharacters = STR_VALIDATE_NAME_TITLE;
    RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return STR_CITY_REQUIRED;
    } else if (!regexp.hasMatch(value)) {
      return Key_SPECIAL_CHAR;
    }
    return null;
  }

  String validateState(String value) {
    String validCharacters = STR_VALIDATE_NAME_TITLE;
    RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return STR_STATE_REQUIRED;
    } else if (!regexp.hasMatch(value)) {
      return Key_SPECIAL_CHAR;
    }
    return null;
  }

  String validateCountry(String value) {
    String validCharacters = STR_VALIDATE_NAME_TITLE;
    RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return STR_COUNTRY_REQUIRED;
    } else if (!regexp.hasMatch(value)) {
      return Key_SPECIAL_CHAR;
    }
    return null;
  }

  String validatePinCode(String value) {
    if (value.length == 0) {
      return KEY_PINCODE_NUMBER_REQUIRED;
    } else if (value.length < 4) {
      return KEY_PIN_NUMBER_LIMIT;
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
          "Submit",
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
}
