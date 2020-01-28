import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  //final Widget inputFormatters;

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
    this.autovalidate = false,
    this.focusNode,
    // this.inputFormatters,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<BoxAppTextField> {
  @override
  Widget build(BuildContext context) {
    TextFormField tf = TextFormField(
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
              fontSize: 16,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w500),
          // prefixText: widget.prefixText,
          prefixIcon: widget.icon,
          // hintText: widget.hintText,
          //  icon: widget.icon),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greytheme900, width: 2))),

      autovalidate: widget.autovalidate,
      validator: widget.validator,
      onSaved: widget.onSaved,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      // inputFormatters: [
      //   new LengthLimitingTextInputFormatter(10),
      // ],
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
