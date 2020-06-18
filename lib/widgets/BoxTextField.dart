import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/theme/colors.dart';

class BoxAppTextField extends StatefulWidget {
  final String tfValue;
  final String placeHolderName;
  final bool obscureText;
  final bool readOnly;
  final bool interactiveSel;
  final bool flexible;
  final String prefixText;
  final String hintText;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final TextInputType keyboardType;
  final Widget icon;
  final bool autovalidate;
  final Function(String) onChanged;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;

  const BoxAppTextField({
    this.onChanged,
    this.tfValue,
    this.placeHolderName,
    this.obscureText = false,
    this.readOnly = false,
    this.interactiveSel = true,
    this.flexible = false,
    this.prefixText,
    this.hintText,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.icon,
    this.inputFormatters,
    this.autovalidate = false,
    this.focusNode,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<BoxAppTextField> {
  @override
  Widget build(BuildContext context) {
    TextFormField tf = TextFormField(
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      enableInteractiveSelection: widget.interactiveSel,
      initialValue: widget.tfValue,
      decoration: new InputDecoration(
          contentPadding: EdgeInsets.all(12.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greentheme100, width: 2),
          ),
          labelText: widget.placeHolderName,
          labelStyle: TextStyle(
              color: greytheme1000,
              fontSize: FONTSIZE_16,
              fontFamily: Constants.getFontType(),
              fontWeight: FontWeight.w500),
          prefixIcon: widget.icon,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greytheme900, width: 2))),
      autovalidate: widget.autovalidate,
      validator: widget.validator,
      onSaved: widget.onSaved,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
    );

    if (widget.flexible) {
      return Flexible(
        child: tf,
      );
    } else {
      return tf;
    }
  }
}
