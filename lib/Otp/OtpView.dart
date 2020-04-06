import 'package:flutter/material.dart';
import 'package:foodzi/Otp/OtpContractor.dart';
import 'package:foodzi/Otp/OtpPresenter.dart';
import 'package:foodzi/ResetPassword/ResetPassView.dart';

import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OTPScreen extends StatefulWidget {
  String mobno;
  int value = 0;
  bool isfromloginotp = false;
  bool isFromFogetPass = false;
  OTPScreen(
      {this.mobno, this.value, this.isFromFogetPass, this.isfromloginotp});
  @override
  State<StatefulWidget> createState() {
    return _OTPScreenState();
  }
}

class _OTPScreenState extends State<OTPScreen> implements OTPModelView {
  var otpsave;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  var otppresenter;
  String mobileNo;
  @override
  void initState() {
    otppresenter = OtpPresenter(this);
    super.initState();
    setState(() {
      mobileNo = widget.mobno;
    });
  }

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
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
    if (widget.value == 0 && otpsave != null) {
      DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
      otppresenter.performOTP(widget.mobno, otpsave, context);
    } else if (widget.isFromFogetPass == true &&
        widget.value != 0 &&
        otpsave != null) {
      DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
      otppresenter.perfromresetpassword(widget.mobno, otpsave, context);
    }
  }

  Widget _buildmainview() {
    return LimitedBox(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildImagelogo(),
            SizedBox(
              height: 30,
            ),
            Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                Text(
                  KEY_VERFICATION_OTP,
                  style: TextStyle(
                      fontSize: FONTSIZE_18,
                      fontFamily: KEY_FONTFAMILY,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                Text(
                  STR_MOBILE_NUMBER,
                  style: TextStyle(
                      fontSize: FONTSIZE_18,
                      fontFamily: KEY_FONTFAMILY,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(height: 35),
            _mobnoEntered(),
            SizedBox(
              height: 10,
            ),
            _buidOTPtextinput(),
            SizedBox(
              height: 20,
            ),
            _resendOtp(),
            SizedBox(
              height: 25,
            ),
            _submitButton(),
            SizedBox(
              height: 50,
            ),
            _anothernumber()
          ],
        ),
      ),
    );
  }

  Widget _buildImagelogo() {
    return Column(
      children: <Widget>[
        Image.asset(OTP_LOGO_PATH),
      ],
    );
  }

  Widget _buidOTPtextinput() {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 42),
        child: PinCodeTextField(
          maxLength: 6,
          wrapAlignment: WrapAlignment.center,
          pinBoxWidth: 36.0,
          pinBoxHeight: 41.0,
          defaultBorderColor: Colors.grey[300],
          hasTextBorderColor: greentheme,
          pinTextStyle: TextStyle(color: Colors.grey[600]),
          pinBoxRadius: 8.0,
          autofocus: false,
          onDone: (String value) {
            otpsave = value;
            print(value);
          },
          pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ),
    );
  }

  Widget _mobnoEntered() {
    return Text(mobileNo,
        style: TextStyle(
            color: greytheme300,
            fontFamily: KEY_FONTFAMILY,
            fontWeight: FontWeight.w600,
            fontSize: FONTSIZE_16));
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
              fontFamily: KEY_FONTFAMILY,
              fontWeight: FontWeight.w600),
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

  Widget _anothernumber() {
    return LimitedBox(
      child: FlatButton(
        child: Text(
          KEY_PROVIDE_ANOTHER_NO,
          style: TextStyle(
              color: greentheme100,
              fontFamily: KEY_FONTFAMILY,
              fontSize: FONTSIZE_16,
              fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.pushNamed(context, STR_ENTER_OTP_PAGE);
        },
      ),
    );
  }

  Widget _resendOtp() {
    return LimitedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            STR_NO_CODE,
            style: TextStyle(
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w600,
                color: greytheme200,
                fontSize: 14),
          ),
          SizedBox(
            width: 3,
          ),
          new GestureDetector(
            onTap: () {
              DialogsIndicator.showLoadingDialog(
                  context, _keyLoader, STR_BLANK);
              otppresenter.resendOTP(widget.mobno, context);
            },
            child: new Text(
              STR_RESEND,
              style: TextStyle(
                  color: greytheme200,
                  fontWeight: FontWeight.w900,
                  fontFamily: KEY_FONTFAMILY,
                  fontSize: FONTSIZE_14),
            ),
          )
        ],
      ),
    );
  }

  @override
  void otpfailed() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void otpsuccess() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();

    Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
  }

  @override
  void getFailedForForgetPass() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void getSuccesForForgetPass() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ResetPasswordview(
              mobno: widget.mobno,
            )));
  }

  @override
  void resendotpfailed() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void resendotpsuccess(message) {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    Constants.showAlert(STR_RESEND_OTP, message, context);
  }

  @override
  void loginwithotpfailed() {}

  @override
  void loginwithotpsuccess() {
    Navigator.pushNamed(context, STR_MAIN_WIDGET_PAGE);
  }
}
