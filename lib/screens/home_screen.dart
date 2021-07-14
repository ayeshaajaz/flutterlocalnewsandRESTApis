import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localnews/data/api.dart';
import 'package:localnews/helper/SharedPreferences.dart';
import 'package:localnews/models/NewsModel.dart';
import 'package:localnews/screens/auth/InitializationScreen.dart';
import 'package:localnews/styles/app_colors.dart';
import 'package:localnews/widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = Api();
  List<NewsModel> newsModel = [];
  @override
  void initState() {
    api.getNewsList().then((value) => setState(() {
          newsModel = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'All News',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () async {
              await signOut();
              // print(userToken);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightGreyBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: newsModel.length,
                    itemBuilder: (BuildContext context, int index) => NewsCard(
                      news: newsModel[index],
                      isAdmin: false,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  signOut() {
    SharedPreferenceHelper.clearSharedPreferenceOnLogOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => InitializationScreen()));
  }
}
