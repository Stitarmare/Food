import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/EnterMobileNoOTP/EnterOTPScreenPresenter.dart';
import 'package:foodzi/EnterMobileNoOTP/EnterOtpContractor.dart';
import 'package:foodzi/OTPScreen/UpdateNoOtpScreen.dart';
import 'package:foodzi/Otp/OtpView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';
import 'package:keyboard_actions/keyboard_action.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:progress_dialog/progress_dialog.dart';

class EnterMobileNoPage extends StatefulWidget {
  int flag = 0;
  EnterMobileNoPage({this.flag});
  @override
  State<StatefulWidget> createState() {
    return EnterMobileNoPageState();
  }
}

class EnterMobileNoPageState extends State<EnterMobileNoPage>
    implements EnterOTPModelView {
  static String mobno = KEY_MOBILE_NUMBER;

  final GlobalKey<FormState> _enterOTPFormKey = GlobalKey<FormState>();
  final FocusNode _nodeText1 = FocusNode();
  ProgressDialog progressDialog;

  bool _validate = false;
  bool isIgnoring = false;
  final Map<String, dynamic> _enterOTP = {
    mobno: null,
  };
  var _mobileNumber;
  var countrycode = '+91';
  var enterOTPScreenPresenter;
  @override
  void initState() {
    enterOTPScreenPresenter = EnterOTPScreenPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return SafeArea(
      top: false,
      right: false,
      left: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white70,
        ),
        body: IgnorePointer(
          ignoring:isIgnoring,
  child:KeyboardActions(
          config: _buildConfig(context),
          child: SingleChildScrollView(
            child: mainview(),
          ),
        ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.39,
                height: 43,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0),
                  ),
                  color: greentheme100,
                  child: Text(
                    KEY_UPDATE,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: KEY_FONTFAMILY,
                        fontSize: FONTSIZE_18,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () => onsubmitButtonClicked(),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.39,
                height: 43,
                child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(6.0),
                      side: BorderSide(color: greytheme100)),
                  child: Text(
                    KEY_CANCEL_UC,
                    style: TextStyle(
                        color: greytheme1000,
                        fontFamily: KEY_FONTFAMILY,
                        fontSize: FONTSIZE_18,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mainview() {
    return Container(
      padding: EdgeInsets.only(
          top: Constants.getScreenHeight(context) * 0.1, left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
    setState(() {
      isIgnoring = true;
    });
    if (_enterOTPFormKey.currentState.validate()) {
      if (widget.flag == 3) {
        await progressDialog.show();
        this
            .enterOTPScreenPresenter
            .requestforUpdateNoOtp(_mobileNumber, countrycode, context);
        _enterOTPFormKey.currentState.save();
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  Widget _buildmainview() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildImagelogo(),
          Form(
            key: _enterOTPFormKey,
            autovalidate: _validate,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Text(
                    KEY_ENTER_NO,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: KEY_FONT_SEGOEUI,
                        fontWeight: FontWeight.w400,
                        fontSize: FONTSIZE_18,
                        color: greytheme200),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(150, 0, 150, 0),
                ),
                SizedBox(height: 45),
                Row(children: <Widget>[
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
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: AppTextField(
                      onChanged: (text) {
                        this._mobileNumber = text;
                      },
                      keyboardType: TextInputType.phone,
                      focusNode: _nodeText1,
                      icon: Icon(
                        Icons.call,
                        color: greentheme100,
                      ),
                      placeHolderName: KEY_MOBILE_NUMBER,
                      validator: validatemobno,
                      onSaved: (String value) {
                        _enterOTP[mobno] = value;
                      },
                    ),
                  ),
                ]),
                // SizedBox(
                //   height: 90,
                // ),
                // _submitButtonClicked(),
              ],
            ),
          ),
        ],
      ),

      // ),
    );
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

  @override
  Future<void> onRequestOtpFailed() async {
    await progressDialog.hide();
  }

  @override
  Future<void> onRequestOtpSuccess() async {
    await progressDialog.hide();
  }

  @override
  Future<void> requestforloginotpfailed() async {
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> requestforloginotpsuccess() async {
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(STR_DONE),
          ),
        ),
      ],
    );
  }

  Widget _buildImagelogo() {
    return Column(
      children: <Widget>[
        Image.asset(OTP_LOGO_PATH),
      ],
    );
  }

  @override
  Future<void> requestforUpdateNoOtpFailed() async {
     setState(() {
      isIgnoring = false;
    });
    
    await progressDialog.hide();
    // TODO: implement requestforUpdateNoOtpFailed
  }

  @override
  Future<void> requestforUpdateNoOtpSuccess() async {
     setState(() {
      isIgnoring = false;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => UpdateNoOTPScreen(
              countryCode: countrycode,
              mobno: _mobileNumber,
            )));
    // TODO: implement requestforUpdateNoOtpSuccess
  }

  @override
  void onProvideOtpFailed() {
    // TODO: implement onProvideOtpFailed
  }

  @override
  void onProvideOtpSuccess() {
    // TODO: implement onProvideOtpSuccess
  }
}
