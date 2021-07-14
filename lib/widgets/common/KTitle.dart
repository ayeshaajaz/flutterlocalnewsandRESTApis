import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KAppTitle extends StatelessWidget {
  final Color textColor;
  const KAppTitle({required this.textColor});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'N',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 50,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
          children: [
            TextSpan(
              text: 'e',
              style: TextStyle(color: Colors.black, fontSize: 50),
            ),
            TextSpan(
              text: 'ws',
              style: TextStyle(color: textColor, fontSize: 50),
            ),
          ]),
    );
  }
}
