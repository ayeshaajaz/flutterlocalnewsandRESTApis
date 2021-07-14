import 'package:flutter/material.dart';
import 'package:localnews/styles/app_colors.dart';

class KGradientButton extends StatelessWidget {
  final String title;
  final double width;
  final VoidCallback onPress;
  final Color textColor;

  const KGradientButton({
    required this.title,
    required this.width,
    required this.onPress,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppColors.gradientColorA, AppColors.gradientColorB])),
        child: Text(title, style: TextStyle(fontSize: 20, color: textColor)),
      ),
    );
  }
}
