import 'package:flutter/material.dart';
import 'package:localnews/data/api.dart';
import 'package:localnews/models/ValidateAdmin.dart';
import 'package:localnews/screens/admin/admin_home_Screen.dart';
import 'package:localnews/screens/auth/signup_screen.dart';
import 'package:localnews/screens/tab.dart';
import 'package:localnews/styles/app_colors.dart';
import 'package:localnews/widgets/common/KBackButton.dart';
import 'package:localnews/widgets/common/KFormInputField.dart';
import 'package:localnews/widgets/common/KGradientButton.dart';
import 'package:localnews/widgets/common/KTitle.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  final api = Api();
  bool loading = false;
  late Validate validate;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  KAppTitle(
                    textColor: AppColors.buttonTextColor,
                  ),
                  SizedBox(height: 50),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(),
                  Column(
                    children: <Widget>[
                      KFormInputField(
                          title: 'Email',
                          isPassword: false,
                          controller: _emailController),
                      KFormInputField(
                          title: "Password",
                          isPassword: true,
                          controller: _passwordController)
                    ],
                  ),
                  SizedBox(height: 20),
                  KGradientButton(
                      title: "Login",
                      width: MediaQuery.of(context).size.width * 0.6,
                      onPress: () async {
                        setState(() {
                          loading = true;
                        });
                        onLogin();
                      },
                      textColor: Colors.white),
                  SizedBox(height: height * .055),
                  createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(
              top: 40,
              left: 0,
              child: KBackButton(onPress: () {
                Navigator.pop(context);
              })),
        ],
      ),
    ));
  }

  onLogin() {
    if (email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email or Password is Required'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        loading = false;
      });
    } else {
      try {
        api.login(email, password).then((value) => {
              validate = Validate.fromMap(value),
              validate.response && validate.isAdmin
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminHomeScreen()),
                      (route) => false)
                  : validate.response && !validate.isAdmin
                      ? Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => TabScreen()),
                          (route) => false)
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Email or Password is Wrong'),
                            backgroundColor: Colors.red,
                          ),
                        ),
            });
        setState(() {
          loading = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Check Your Connection'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget createAccountLabel() => InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.all(15),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Don\'t have an account ?',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Register',
                style: TextStyle(
                    color: AppColors.buttonTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
}
