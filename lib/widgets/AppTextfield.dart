import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final String tfValue;
  final String placeHolderName;
  final bool obscureText;
  final bool readOnly;
  final bool enable;
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
  final String strErrortext;
  final String initialvalue;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;

  const AppTextField({
    this.initialvalue,
    this.onChanged,
    this.tfValue,
    this.enable,
    this.controller,
    this.placeHolderName,
    this.strErrortext,
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
    this.inputFormatters,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    TextFormField tf = TextFormField(
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      controller: widget.controller,
      readOnly: widget.readOnly,
      enableInteractiveSelection: widget.interactiveSel,
      initialValue: widget.tfValue,
      enabled: widget.enable,
      decoration: InputDecoration(
        labelText: widget.placeHolderName,
        prefixIcon: widget.icon,
      ),
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
