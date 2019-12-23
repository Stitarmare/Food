import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/widgets/AppTextfield.dart';

class EnterOTPScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EnterOTPScreenState();
  }
}

class EnterOTPScreenState extends State<EnterOTPScreen> {
  static String mobno = KEY_MOBILE_NUMBER;

  final GlobalKey<FormState> _enterOTPFormKey = GlobalKey<FormState>();

  bool _validate = false;
  final Map<String, dynamic> _enterOTP = {
    mobno: null,
  };

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
      _enterOTPFormKey.currentState.save();
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
              key: _enterOTPFormKey,
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  _buildImagelogo(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    KEY_VERFICATION_OTP,
                    maxLines: 2,
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 150, 0),
                  ),
                  AppTextField(
                    keyboardType: TextInputType.phone,
                    icon: Icon(Icons.call),
                    placeHolderName: KEY_MOBILE_NUMBER,
                    validator: validatemobno,
                    onSaved: (String value) {
                      _enterOTP[mobno] = value;
                    },
                  ),
                  SizedBox(
                    height: 50,
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
      minWidth: 350,
      height: 50,
      child: RaisedButton(
        color: Color.fromRGBO(34, 180, 91, 0.80),
        onPressed: () => onsubmitButtonClicked(),
        child: Text(
          KEY_SUBMIT_BUTTON,
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
}
