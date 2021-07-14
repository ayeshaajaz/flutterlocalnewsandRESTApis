import 'package:flutter/material.dart';

class KFormButton extends StatelessWidget {
  final String title;
  final double width;
  final VoidCallback onPress;
  final Color color;
  final Color textColor;
  final bool boxShadow;
  final bool border;

  const KFormButton(
      {required this.title,
      required this.width,
      required this.onPress,
      required this.color,
      required this.textColor,
      required this.boxShadow,
      required this.border});

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
            border: border ? Border.all(color: Colors.white, width: 2) : null,
            boxShadow: boxShadow
                ? <BoxShadow>[
                    BoxShadow(
                        color: color,
                        offset: Offset(2, 4),
                        blurRadius: 8,
                        spreadRadius: 2)
                  ]
                : null,
            color: boxShadow ? Colors.white : null),
        child: Text(title, style: TextStyle(fontSize: 20, color: textColor)),
      ),
    );
  }
}
