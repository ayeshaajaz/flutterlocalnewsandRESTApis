import 'package:flutter/material.dart';
import 'package:localnews/styles/app_colors.dart';

class KTextField extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final TextStyle hintTextStyle;
  final TextStyle textStyle;
  final bool hasFocus;
  final int maxLines;

  KTextField(
      {required this.hintText,
      required this.textInputType,
      required this.textInputAction,
      required this.controller,
      required this.hintTextStyle,
      required this.textStyle,
      required this.maxLines,
      required this.hasFocus});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 48,
      alignment: Alignment.center,
      child: Center(
        child: TextField(
          maxLines: maxLines,
          controller: controller,
          keyboardType: textInputType,
          textAlignVertical: TextAlignVertical.center,
          style: textStyle,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              hintText: hintText,
              hintStyle: hintTextStyle,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.borderColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.borderColor))),
        ),
      ),
    );
  }
}
