import 'package:flutter/material.dart';
import 'package:localnews/styles/app_colors.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool obscureText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final TextStyle hintTextStyle;
  final TextStyle textStyle;
  final bool hasFocus;
  Function submitted;

  SearchBar({
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    this.obscureText = false,
    required this.textInputType,
    required this.textInputAction,
    required this.controller,
    required this.hintTextStyle,
    this.hasFocus = false,
    required this.textStyle,
    required this.submitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(2),
      child: TextField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        obscureText: obscureText,
        onSubmitted: (String? val) {
          submitted = val as Function;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            hintText: hintText,
            hintStyle: hintTextStyle,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.greyAppBar),
            ),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.borderColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.borderColor))),
      ),
    );
  }
}
