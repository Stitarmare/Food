import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/ResetPassword/ResetPassPresenter.dart';
import 'package:foodzi/ResetPassword/ResetpassContractor.dart';
import 'dart:math' as math;
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ResetPasswordview extends StatefulWidget {
  var mobno;
  var countryCode;
  ResetPasswordview({this.mobno, this.countryCode});
  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordview();
  }
}

class _ResetPasswordview extends State<ResetPasswordview>
    implements ResetPassModelView {
  static String enterPass = KEY_ENTER_PASSWORD;
  static String enterConfirmPass = KEY_CONFIRM_PASSWORD;

  final GlobalKey<FormState> _resetpasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  bool _validate = false;
  ProgressDialog progressDialog;

  final Map<String, dynamic> _signInData = {
    enterPass: null,
    enterConfirmPass: null,
  };

  var resetpasswordPresenter;
  var _password = STR_BLANK;
  var _confirmPassword = STR_BLANK;

  @override
  void initState() {
    resetpasswordPresenter = ResetpasswordPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.dark,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white70,
            title: Image.asset(
              FOODZI_LOGO_PATH,
              height: 50,
            )),
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

  Future<void> onsubmitButtonClicked() async {
    if (_resetpasswordFormKey.currentState.validate()) {
      await progressDialog.show();
      //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
      resetpasswordPresenter.perfromresetpassword(
          widget.mobno, widget.countryCode, _password, context);
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
              key: _resetpasswordFormKey,
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  _buildImagelogo(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    STR_RESET_PASSWORD,
                    style: TextStyle(
                        fontFamily: Constants.getFontType(),
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
                  _signinButton(),
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
        Image.asset(IMAGE_LOCK_PATH),
      ],
    );
  }

  Widget _buildTextField() {
    const pi = PI_VALUE;
    return Column(
      children: <Widget>[
        AppTextField(
          inputFormatters: [
            BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT)),
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
        SizedBox(height: 15),
        AppTextField(
          inputFormatters: [
            BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT)),
          ],
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
            _signInData[enterPass] = value;
          },
        ),
      ],
    );
  }

  String validatepassword(String value) {
    if (value.length == 0) {
      return KEY_PASSWORD_REQUIRED;
    } else if (value.length < 8) {
      return PASSWORD_SHOULD_BE_MIN_8_CHAR_LONG;
    }
    return null;
  }

  String validatConfirmPassword(String value) {
    if (value.length == 0) {
      return KEY_PASSWORD_REQUIRED;
    } else if (value.length < 8) {
      return PASSWORD_SHOULD_BE_MIN_8_CHAR_LONG;
    }
    return null;
  }

  Widget _signinButton() {
    return ButtonTheme(
      minWidth: 280,
      height: 54,
      child: RaisedButton(
        color: greentheme100,
        onPressed: () => onsubmitButtonClicked(),
        child: Text(
          KEY_SUBMIT_BUTTON,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
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

  showDialogBox(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text(
            STR_RESET_PASSWORD,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: greentheme100,
                fontWeight: FontWeight.w600,
                fontFamily: KEY_FONTFAMILY,
                fontSize: 22),
          ),
          content: Text(
            _password == _confirmPassword
                ? STR_PWD_CHANGED
                : STR_PWD_NOT_MATCHED,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: greytheme100,
                fontWeight: FontWeight.w500,
                fontFamily: Constants.getFontType(),
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
                _password == _confirmPassword
                    ? Navigator.of(context).pushReplacementNamed(STR_LOGIN_PAGE)
                    : Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> resetpassfailed() async {
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> resetpasssuccess() async {
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    showDialogBox(context);
  }
}
