// A widget housing bordered input box with text holder that moves on tap. The
// widget allows the customization of its text colour, placeholder colour and
// active border colour.

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String placeholder;
  final Color cursorColor;
  final Color placeholderColor;
  final Color focusedOutlineBorder;
  final bool isPassword;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;

  CustomTextField(
      {@required this.placeholder,
      this.cursorColor = Colors.redAccent,
      this.placeholderColor = Colors.redAccent,
      this.focusedOutlineBorder = Colors.redAccent,
      this.onChanged,
      this.isPassword = false,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: this.isPassword,
      cursorColor: this.cursorColor,
      decoration: InputDecoration(
        labelText: this.placeholder,
        hasFloatingPlaceholder: true,
        labelStyle: TextStyle(
          color: this.placeholderColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: this.focusedOutlineBorder,
          ),
        ),
      ),
      onChanged: this.onChanged,
    );
  }
}
