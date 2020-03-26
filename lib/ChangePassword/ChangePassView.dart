import 'package:flutter/material.dart';
import 'package:foodzi/ChangePassword/ChangePasswordContractor.dart';
import 'package:foodzi/ChangePassword/ChangePasswordPresenter.dart';
import 'dart:math' as math;
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';

class ChangePasswordview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordview();
  }
}

class _ChangePasswordview extends State<ChangePasswordview>
    implements ChangePasswordModelView {
  static String enterOldPass = KEY_ENTER_OLD_PASSWORD;
  static String enterNewPass = KEY_ENTER_NEW_PASSWORD;
  static String enterConfirmPass = KEY_CONFIRM_PASSWORD;

  final GlobalKey<FormState> _changepasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  bool _validate = false;

  final Map<String, dynamic> _changePassData = {
    enterOldPass: null,
    enterNewPass: null,
    enterConfirmPass: null,
  };

  var changepasswordPresenter;
  var _oldPassword = '';
  var _newPassword = '';
  var _confirmPassword = '';

  @override
  void initState() {
    changepasswordPresenter = ChangePasswordPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
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

  void onsubmitButtonClicked() {
    if (_changepasswordFormKey.currentState.validate()) {
      DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
      changepasswordPresenter.performChangePassword(
          _oldPassword, _newPassword, _confirmPassword, context);
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
              key: _changepasswordFormKey,
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  _buildImagelogo(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    STR_CHANGE_PASSWORD,
                    style: TextStyle(
                        fontFamily: KEY_FONTFAMILY,
                        color: greytheme300,
                        fontSize: FONTSIZE_18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildTextField(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 150, 0),
                  ),
                  SizedBox(
                    height: 78,
                  ),
                  _submitButton(),
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
        Image.asset(STR_GROUP_IMAGE),
      ],
    );
  }

  Widget _buildTextField() {
    const pi = PI_VALUE;
    return Column(
      children: <Widget>[
        AppTextField(
          onChanged: (text) {
            _oldPassword = text;
          },
          obscureText: true,
          placeHolderName: KEY_ENTER_OLD_PASSWORD,
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
            print(value);
            _changePassData[enterOldPass] = value;
          },
        ),
        SizedBox(height: 15),
        AppTextField(
          onChanged: (text) {
            _newPassword = text;
          },
          obscureText: true,
          placeHolderName: KEY_ENTER_NEW_PASSWORD,
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
            print(value);
            _changePassData[enterNewPass] = value;
          },
        ),
        SizedBox(height: 15),
        AppTextField(
          onChanged: (text) {
            _confirmPassword = text;
          },
          obscureText: true,
          placeHolderName: KEY_CONFIRM_PASSWORD,
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
          validator: validatConfirmPassword,
          onSaved: (String value) {
            print(value);
            _changePassData[enterConfirmPass] = value;
          },
        ),
      ],
    );
  }

  String validatepassword(String value) {
    if (value.length == 0) {
      return KEY_PASSWORD_REQUIRED;
    } else if (value.length < 8) {
      return KEY_THIS_SHOULD_BE_MIN_8_CHAR_LONG;
    }
    return null;
  }

  String validatConfirmPassword(String value) {
    if (value.length == 0) {
      return KEY_PASSWORD_REQUIRED;
    } else if (value.length < 8) {
      return KEY_THIS_SHOULD_BE_MIN_8_CHAR_LONG;
    } else if (value != _newPassword) {
      return STR_PWD_NOT_MATCHED;
    }
    return null;
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

  showDialogBox(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text(
            KEY_CHANGE_PASSWORD,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: greentheme100,
                fontWeight: FontWeight.w600,
                fontFamily: KEY_FONTFAMILY,
                fontSize: FONTSIZE_22),
          ),
          content: Text(
            STR_PWD_CHANGED_SUCCESS,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: greytheme100,
                fontWeight: FontWeight.w500,
                fontFamily: KEY_FONTFAMILY,
                fontSize: FONTSIZE_20),
          ),
          actions: [
            FlatButton(
              child: const Text(
                STR_OK,
                style: TextStyle(
                    color: greentheme100,
                    fontWeight: FontWeight.w600,
                    fontFamily: KEY_FONTFAMILY,
                    fontSize: FONTSIZE_20),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/MainWidget');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void changePasswordfailed() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void changePasswordsuccess() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    showDialogBox(context);
  }
}
