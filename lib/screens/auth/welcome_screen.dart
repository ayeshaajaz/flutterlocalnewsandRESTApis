import 'package:flutter/material.dart';
import 'package:localnews/screens/auth/login_screen.dart';
import 'package:localnews/screens/auth/signup_screen.dart';
import 'package:localnews/styles/app_colors.dart';
import 'package:localnews/widgets/common/KFormButton.dart';
import 'package:localnews/widgets/common/KTitle.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.gradientColorA,
                  AppColors.gradientColorB,
                ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            KAppTitle(
              textColor: Colors.white,
            ),
            SizedBox(
              height: 80,
            ),
            KFormButton(
                title: "LogIn",
                width: MediaQuery.of(context).size.width * 0.6,
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInScreen()));
                },
                boxShadow: true,
                border: false,
                color: Color(0xffdf8e33).withAlpha(100),
                textColor: AppColors.buttonTextColor),
            SizedBox(
              height: 20,
            ),
            KFormButton(
                title: "Register Now",
                width: MediaQuery.of(context).size.width * 0.6,
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                border: true,
                boxShadow: false,
                color: Colors.white,
                textColor: Colors.white),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
