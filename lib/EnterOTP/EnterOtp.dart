import 'package:flutter/material.dart';
import 'package:foodzi/EnterOTP/EnterOTPScreenPresenter.dart';
import 'package:foodzi/EnterOTP/EnterOtpContractor.dart';
import 'package:foodzi/Otp/OtpView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';

class EnterOTPScreen extends StatefulWidget {
  int flag = 0;
  EnterOTPScreen({this.flag});
  @override
  State<StatefulWidget> createState() {
    return EnterOTPScreenState();
  }
}

class EnterOTPScreenState extends State<EnterOTPScreen>
    implements EnterOTPModelView {
  static String mobno = KEY_MOBILE_NUMBER;

  final GlobalKey<FormState> _enterOTPFormKey = GlobalKey<FormState>();

  bool _validate = false;
  final Map<String, dynamic> _enterOTP = {
    mobno: null,
  };
  var _mobileNumber;

  var enterOTPScreenPresenter;
  @override
  void initState() {
    // TODO: implement initState

    enterOTPScreenPresenter = EnterOTPScreenPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
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
      margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
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
    if (_enterOTPFormKey.currentState.validate()) {
      if (widget.flag == 1) {
        this.enterOTPScreenPresenter.requestForOTP(_mobileNumber, context);
      } else if (widget.flag == 2) {
        this.enterOTPScreenPresenter.requestforloginOTP(_mobileNumber, context);
        _enterOTPFormKey.currentState.save();
        // Navigator.pushNamed(context, '/OTPScreen');
      }
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
              key: _enterOTPFormKey,
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  _buildImagelogo(),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Text(
                      KEY_GET_OTP_ENTER_NO,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          fontFamily: 'SegoeUI',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: greytheme200),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 150, 0),
                  ),
                  SizedBox(height: 45),
                  AppTextField(
                    onChanged: (text) {
                      this._mobileNumber = text;
                    },
                    keyboardType: TextInputType.phone,
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
                  SizedBox(
                    height: 90,
                  ),
                  _submitButtonClicked(),
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
        Image.asset('assets/PhoneImage/Group_295.png'
            //height: 100,
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

  Widget _submitButtonClicked() {
    return ButtonTheme(
      minWidth: 280,
      height: 54,
      child: RaisedButton(
        color: greentheme100,
        onPressed: () => onsubmitButtonClicked(),
        child: Text(
          KEY_SUBMIT_BUTTON,
          style: TextStyle(
              fontSize: 16, fontFamily: 'gotham', fontWeight: FontWeight.w700),
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

  @override
  void onRequestOtpFailed() {
    // TODO: implement onRequestOtpFailed
  }

  @override
  void onRequestOtpSuccess() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => OTPScreen(
              mobno: _mobileNumber,
              isFromFogetPass: true,
              value: 1,
            )));
  }

  @override
  void requestforloginotpfailed() {
    // TODO: implement requestforloginotpfailed
  }

  @override
  void requestforloginotpsuccess() {
    Navigator.pushReplacementNamed(context, '/MainWidget');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => OTPScreen(
              mobno: _mobileNumber,
              isfromloginotp: true,
              value: 0,
            )));
    // TODO: implement requestforloginotpsuccess
  }
}
