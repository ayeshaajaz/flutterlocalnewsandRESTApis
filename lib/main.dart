import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localnews/helper/SharedPreferences.dart';
import 'package:localnews/screens/auth/InitializationScreen.dart';
import 'package:localnews/screens/auth/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Local News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InitializationScreen(),
    );
  }
}
