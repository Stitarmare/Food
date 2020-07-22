import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodzi/EnterMobileNoOTP/EnterOTPScreenPresenter.dart';
import 'package:foodzi/EnterMobileNoOTP/EnterOtpContractor.dart';
import 'package:foodzi/Otp/OtpContractor.dart';
import 'package:foodzi/Otp/OtpPresenter.dart';
import 'package:foodzi/ResetPassword/ResetPassView.dart';

import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UpdateNoOTPScreen extends StatefulWidget {
  String mobno;
  String countryCode;
  UpdateNoOTPScreen({
    this.mobno,
    this.countryCode,
  });
  @override
  State<StatefulWidget> createState() {
    return _UpdateNoOTPScreenState();
  }
}

class _UpdateNoOTPScreenState extends State<UpdateNoOTPScreen>
    with TickerProviderStateMixin
    implements OTPModelView, EnterOTPModelView {
  var otpsave;
  OtpPresenter otppresenter;
  var enterOTPScreenPresenter;
  String mobileNo;
  String countryCode;
  ProgressDialog progressDialog;
  bool isLoader = false;

  @override
  void initState() {
    otppresenter = OtpPresenter(this);
    enterOTPScreenPresenter = EnterOTPScreenPresenter(this);

    super.initState();
    setState(() {
      mobileNo = widget.mobno;
      countryCode = widget.countryCode;
    });
  }

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
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Stack(children: <Widget>[
              mainview(),
              isLoader
                  ? SpinKitFadingCircle(
                      color: Globle().colorscode != null
                          ? getColorByHex(Globle().colorscode)
                          : orangetheme300,
                      size: 50.0,
                      controller: AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 1200)),
                    )
                  : Text("")
            ]),
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

  Future<void> onsubmitButtonClicked() async {
    if ((otpsave != null)) {
      // await progressDialog.show();
      setState(() {
        isLoader = true;
      });
      //API call
      otppresenter.performOTPUpdateNo(mobileNo, countryCode, otpsave, context);
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
                      fontFamily: Constants.getFontType(),
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
                      fontFamily: Constants.getFontType(),
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
            // _anothernumber()
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
            fontFamily: Constants.getFontType(),
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
              fontFamily: Constants.getFontType(),
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

  Widget _resendOtp() {
    return LimitedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            STR_NO_CODE,
            style: TextStyle(
                fontFamily: Constants.getFontType(),
                fontWeight: FontWeight.w600,
                color: greytheme200,
                fontSize: 14),
          ),
          SizedBox(
            width: 3,
          ),
          new GestureDetector(
            onTap: () async {
              // DialogsIndicator.showLoadingDialog(
              //     context, _keyLoader, STR_BLANK);
              await progressDialog.show();
              this
                  .enterOTPScreenPresenter
                  .requestforUpdateNoOtp(mobileNo, countryCode, context);
              // otppresenter.resendOTP(mobileNo, countryCode, context);
            },
            child: new Text(
              STR_RESEND,
              style: TextStyle(
                  color: greytheme200,
                  fontWeight: FontWeight.w900,
                  fontFamily: Constants.getFontType(),
                  fontSize: FONTSIZE_14),
            ),
          )
        ],
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
            KEY_SUCCESS,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: greentheme100,
                fontWeight: FontWeight.w600,
                fontFamily: KEY_FONTFAMILY,
                fontSize: 22),
          ),
          content: Text(
            STR_UPDATE_NO_SUCCESS,
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
                Navigator.of(context).pushReplacementNamed(STR_LOGIN_PAGE);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> otpfailed() async {
    await progressDialog.hide();
    setState(() {
      isLoader = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> otpsuccess() async {
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    await progressDialog.hide();
    setState(() {
      isLoader = false;
    });
    Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
  }

  @override
  Future<void> resendotpfailed() async {
    await progressDialog.hide();
    setState(() {
      isLoader = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> resendotpsuccess(message) async {
    await progressDialog.hide();
    setState(() {
      isLoader = false;
    });
    Constants.showAlert(STR_RESEND_OTP, message, context);
  }

  @override
  Future<void> performOTPUpdateNoFailed() async {
    await progressDialog.hide();
    setState(() {
      isLoader = false;
    });
    // TODO: implement performOTPUpdateNoFailed
  }

  @override
  Future<void> performOTPUpdateNoSuccess() async {
    await progressDialog.hide();
    setState(() {
      isLoader = false;
    });
    showDialogBox(context);
    // TODO: implement performOTPUpdateNoSuccess
  }

  @override
  void getFailedForForgetPass() {
    // TODO: implement getFailedForForgetPass
  }

  @override
  void getSuccesForForgetPass() {
    // TODO: implement getSuccesForForgetPass
  }

  @override
  void loginwithotpfailed() {
    // TODO: implement loginwithotpfailed
  }

  @override
  void loginwithotpsuccess() {
    // TODO: implement loginwithotpsuccess
  }

  @override
  void onRequestOtpFailed() {
    // TODO: implement onRequestOtpFailed
  }

  @override
  void onRequestOtpSuccess() {
    // TODO: implement onRequestOtpSuccess
  }

  @override
  void requestforUpdateNoOtpFailed() {
    setState(() {
      isLoader = false;
    });
    // TODO: implement requestforUpdateNoOtpFailed
  }

  @override
  Future<void> requestforUpdateNoOtpSuccess() async {
    await progressDialog.hide();
    setState(() {
      isLoader = false;
    });
    Constants.showAlert(STR_RESEND_OTP, STR_RESEND_OTP_SUCCESS, context);
    // TODO: implement requestforUpdateNoOtpSuccess
  }

  @override
  void requestforloginotpfailed() {
    // TODO: implement requestforloginotpfailed
  }

  @override
  void requestforloginotpsuccess() {
    // TODO: implement requestforloginotpsuccess
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
