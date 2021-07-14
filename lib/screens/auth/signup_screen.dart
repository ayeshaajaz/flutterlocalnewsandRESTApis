import 'package:flutter/material.dart';
import 'package:localnews/data/api.dart';
import 'package:localnews/models/RegisterData.dart';
import 'package:localnews/screens/auth/login_screen.dart';
import 'package:localnews/styles/app_colors.dart';
import 'package:localnews/widgets/common/KBackButton.dart';
import 'package:localnews/widgets/common/KFormInputField.dart';
import 'package:localnews/widgets/common/KGradientButton.dart';
import 'package:localnews/widgets/common/KTitle.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confrimPasswordController = TextEditingController();
  final _genderController = TextEditingController();

  String get fname => _fNameController.text.trim();
  String get lname => _lNameController.text.trim();
  String get email => _emailController.text.trim().toLowerCase();
  String get gender => _genderController.text.trim().toLowerCase();
  String get password => _passwordController.text.trim();
  String get cPassword => _confrimPasswordController.text.trim();

  final api = Api();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    KAppTitle(textColor: AppColors.buttonTextColor),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: <Widget>[
                        KFormInputField(
                            title: 'First Name',
                            isPassword: false,
                            controller: _fNameController),
                        KFormInputField(
                            title: "Last Name",
                            isPassword: false,
                            controller: _lNameController),
                        KFormInputField(
                            title: 'Email',
                            isPassword: false,
                            controller: _emailController),
                        KFormInputField(
                            title: "Gender",
                            isPassword: false,
                            controller: _genderController),
                        KFormInputField(
                            title: 'Password',
                            isPassword: true,
                            controller: _passwordController),
                        KFormInputField(
                            title: "Confirm Password",
                            isPassword: true,
                            controller: _confrimPasswordController)
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    KGradientButton(
                        title: "Register Now",
                        width: MediaQuery.of(context).size.width * 0.7,
                        onPress: () async {
                          await onRegister();
                        },
                        textColor: Colors.white),
                    SizedBox(height: height * .05),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 40,
                left: 0,
                child: KBackButton(
                  onPress: () {
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  onRegister() {
    if (gender == '' ||
        fname == "" ||
        lname == "" ||
        email == "" ||
        password == "" ||
        cPassword == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All fields are aequire'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('email formate is not correct'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (password != cPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('password dose not match! please try again'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'password must be greater than 8 and should container number and characters'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        var data = RegisterData(
            gender: gender,
            fname: fname,
            lname: lname,
            email: email,
            password: password,
            cPassword: cPassword);
        api.register(data).then((value) => value
            ? {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Account Register'),
                    backgroundColor: Colors.green,
                  ),
                ),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInScreen()))
              }
            : ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account not Register! Please try again'),
                  backgroundColor: Colors.red,
                ),
              ));
      } catch (e) {}
    }
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogInScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
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
}
