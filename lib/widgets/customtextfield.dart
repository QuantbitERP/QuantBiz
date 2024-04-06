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

      style: TextStyle(fontSize: 14.0, color: Colors.black), // Adjust font size and color
      decoration: InputDecoration(
       suffixIcon: suffixicon,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        labelStyle: const TextStyle(
          color: Colors.black54, // Customize label text color
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey, // Customize hint text color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.blue, // Customize focused border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.grey, // Customize enabled border color
          ),
        ),
      ),
    );
  }
}
