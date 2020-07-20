import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';

class EmailReceiptDialogView extends StatefulWidget {
  @override
  _EmailReceiptDialogViewState createState() => _EmailReceiptDialogViewState();
}

class _EmailReceiptDialogViewState extends State<EmailReceiptDialogView> {
  final GlobalKey<FormState> _emailIdKey = GlobalKey<FormState>();
  bool _validate = false;
  String strEmailId;
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      children: <Widget>[
        Container(
            height: 175,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _emailIdKey,
              autovalidate: _validate,
              child: Column(children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    "Email Receipt",
                    style: TextStyle(
                        fontSize: FONTSIZE_18,
                        color: greytheme700,
                        fontFamily: Constants.getFontType(),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: AppTextField(
                    controller: _controller,
                    onChanged: (text) {
                      strEmailId = text;
                    },
                    icon: Icon(
                      Icons.mail,
                      color: greytheme1000,
                    ),
                    placeHolderName: "Enter Email_id to send receipt",
                    validator: validateEmailId,
                  ),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: Colors.blue,
                  child: Text(
                    "Send ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: emailIdBtn,
                ),
              ]),
            ))
      ],
    );
  }

  Future<void> emailIdBtn() async {
    if (_emailIdKey.currentState.validate()) {
      if (_controller.text != null) {
        Navigator.of(context).pop({"textValue": _controller.value.text});
      }
      print("emailId");
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  String validateEmailId(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Email_id should not be empty";
    } else if (!regExp.hasMatch(value)) {
      return "Enter proper email_id";
    }
    return null;
  }
}
