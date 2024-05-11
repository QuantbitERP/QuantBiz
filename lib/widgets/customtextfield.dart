import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSmallTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Widget? suffixicon;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardtype;
  final int? length;
  final bool? readOnly;
   final int? linelength;

  const CustomSmallTextFormField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.validator,
    this.readOnly,
    this.onChanged,this.keyboardtype,  this.length, this.linelength, this.suffixicon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
readOnly: readOnly ?? false,
  maxLines: linelength,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      keyboardType: keyboardtype,

      style: TextStyle(fontSize: 14.0, color: Colors.black),
        decoration: InputDecoration(
          suffixIcon: suffixicon,
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide:
              BorderSide(color: Colors.blue, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide:
              BorderSide(color: Colors.grey, width: 2)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.black45, width: 2)),
        ),// Adjust font size and color

    );
  }
}
