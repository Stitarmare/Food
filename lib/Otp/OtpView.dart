import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodzi/EnterMobileNoOTP/EnterOtp.dart';
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

class OTPScreen extends StatefulWidget {
  String mobno;
  String countryCode;
  int value = 0;
  bool isfromloginotp = false;
  bool isFromFogetPass = false;
  bool isFromUpadateNo = false;
  bool isProvideAnotherNumber = false;
  OTPScreen(
      {this.mobno,
      this.countryCode,
      this.value,
      this.isFromFogetPass,
      this.isProvideAnotherNumber,
      this.isfromloginotp,
      this.isFromUpadateNo});
  @override
  State<StatefulWidget> createState() {
    return _OTPScreenState();
  }
}

class _OTPScreenState extends State<OTPScreen>
    with TickerProviderStateMixin
    implements OTPModelView {
  String otpsave;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  OtpPresenter otppresenter;
  String mobileNo;
  String countryCode;
  ProgressDialog progressDialog;
  bool isIgnoreTouch = false;
  bool isLoader = false;

  @override
  void initState() {
    otppresenter = OtpPresenter(this);
    super.initState();
    setState(() {
      mobileNo = widget.mobno;
      countryCode = widget.countryCode;
    });
  }

  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return IgnorePointer(
      ignoring: isIgnoreTouch,
      child: Scaffold(
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
              child: Stack(alignment: Alignment.center, children: <Widget>[
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
          )),
    );
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
    if (otpsave != null && otpsave.length == 6) {
      setState(() {
        isIgnoreTouch = true;
        isLoader = true;
      });
      if (widget.value == 0 && otpsave != null) {
        // await progressDialog.show();
        //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
        otppresenter.performOTP(
            widget.mobno, widget.countryCode, otpsave, context);
      } else if (widget.isFromFogetPass == true &&
          widget.value == 1 &&
          otpsave != null) {
        // await progressDialog.show();
        //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
        otppresenter.perfromresetpassword(
            widget.mobno, widget.countryCode, otpsave, context);
      } else if ((widget.isFromUpadateNo == true &&
          widget.value == 2 &&
          otpsave != null)) {
        // await progressDialog.show();
      } else if ((widget.isProvideAnotherNumber == true &&
          widget.value == 3 &&
          otpsave != null)) {
        // await progressDialog.show();
        otppresenter.performOTP(
            widget.mobno, widget.countryCode, otpsave, context);
      }
    } else {
      Constants.showAlert("Error", "Please enter otp", context);
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
          hasTextBorderColor: greentheme400,
          pinTextStyle: TextStyle(color: Colors.grey[600]),
          pinBoxRadius: 8.0,
          autofocus: false,
          onTextChanged: (value) {
            setState(() {
              print(value);
              otpsave = value;
            });
          },
          // onDone: (String value) {
          //   setState(() {
          //     otpsave = value;
          //   });
          //   print(value);
          // },
          pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ),
    );
  }

  Widget _mobnoEntered() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(countryCode,
            style: TextStyle(
                color: greytheme300,
                fontFamily: Constants.getFontType(),
                fontWeight: FontWeight.w600,
                fontSize: FONTSIZE_16)),
        SizedBox(
          width: 5,
        ),
        Text(mobileNo,
            style: TextStyle(
                color: greytheme300,
                fontFamily: Constants.getFontType(),
                fontWeight: FontWeight.w600,
                fontSize: FONTSIZE_16)),
      ],
    );
  }

  Widget _submitButton() {
    return ButtonTheme(
      minWidth: 280,
      height: 54,
      child: RaisedButton(
        color: greentheme400,
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

  Widget _anothernumber() {
    return LimitedBox(
      child: FlatButton(
        child: Text(
          KEY_PROVIDE_ANOTHER_NO,
          style: TextStyle(
              color: greentheme400,
              fontFamily: Constants.getFontType(),
              fontSize: FONTSIZE_16,
              fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          // Navigator.pushNamed(context, STR_ENTER_OTP_PAGE);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EnterOTPScreen(
                        flag: 3,
                      )));
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
              otppresenter.resendOTP(widget.mobno, widget.countryCode, context);
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

  @override
  Future<void> otpfailed() async {
    setState(() {
      isIgnoreTouch = false;
      isLoader = false;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> otpsuccess() async {
    setState(() {
      isIgnoreTouch = false;
      isLoader = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    await progressDialog.hide();
    Navigator.of(context).popUntil((route) => route.isFirst);

    Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
  }

  @override
  Future<void> getFailedForForgetPass() async {
    setState(() {
      isIgnoreTouch = false;
      isLoader = false;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> getSuccesForForgetPass() async {
    setState(() {
      isIgnoreTouch = false;
      isLoader = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    await progressDialog.hide();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ResetPasswordview(
              mobno: widget.mobno,
              countryCode: widget.countryCode,
            )));
  }

  @override
  Future<void> resendotpfailed() async {
    setState(() {
      isIgnoreTouch = false;
      isLoader = false;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> resendotpsuccess(message) async {
    setState(() {
      isIgnoreTouch = false;
      isLoader = false;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    Constants.showAlert(STR_RESEND_OTP, message, context);
  }

  @override
  void loginwithotpfailed() {
    setState(() {
      isIgnoreTouch = false;
      isLoader = false;
    });
  }

  @override
  void loginwithotpsuccess() {
    setState(() {
      isIgnoreTouch = false;
      isLoader = false;
    });
    Navigator.pushNamed(context, STR_MAIN_WIDGET_PAGE);
  }

  @override
  void performOTPUpdateNoFailed() {
    setState(() {
      isIgnoreTouch = false;
      isLoader = false;
    });
  }

  @override
  void performOTPUpdateNoSuccess() {
    setState(() {
      isIgnoreTouch = false;
      isLoader = false;
    });
  }
}
