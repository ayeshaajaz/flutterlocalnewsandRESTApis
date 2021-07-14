import 'package:flutter/material.dart';
import 'package:localnews/helper/SharedPreferences.dart';
import 'package:localnews/screens/auth/welcome_screen.dart';
import 'package:localnews/screens/tab.dart';

class InitializationScreen extends StatefulWidget {
  InitializationScreen({Key? key}) : super(key: key);

  @override
  _InitializationScreenState createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    SharedPreferenceHelper.getUserLoggedInSharedPreference()
        .then((value) => value == null
            ? print(value)
            : setState(() {
                isLoggedIn = value;
              }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? TabScreen() : WelcomePage();
  }
}
