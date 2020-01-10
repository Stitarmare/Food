import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
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
  //final Widget inputFormatters;

  const AppTextField({
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
    // this.inputFormatters,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    TextFormField tf = TextFormField(
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      enableInteractiveSelection: widget.interactiveSel,
      initialValue: widget.tfValue,
      decoration: InputDecoration(
        labelText: widget.placeHolderName,
        // prefixText: widget.prefixText,
        prefixIcon: widget.icon,
        // hintText: widget.hintText,
        //  icon: widget.icon),
      ),
      autovalidate: widget.autovalidate,
      validator: widget.validator,
      onSaved: widget.onSaved,
      keyboardType: widget.keyboardType,
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
