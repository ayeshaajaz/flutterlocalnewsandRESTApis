import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localnews/data/api.dart';
import 'package:localnews/helper/SharedPreferences.dart';
import 'package:localnews/models/NewsModel.dart';
import 'package:localnews/screens/auth/InitializationScreen.dart';
import 'package:localnews/screens/create_news_screen.dart';
import 'package:localnews/screens/profile_screen.dart';
import 'package:localnews/styles/app_colors.dart';
import 'package:localnews/widgets/news_card.dart';

class AdminHomeScreen extends StatefulWidget {
  AdminHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int selectedIndex = 0;
  final api = Api();
  List<NewsModel> newsModel = [];
  List newsCategory = ['Approved', 'Pending'];
  String userToken = "";
  String userId = "";
  List<NewsModel> filterCategoryNews = [];
  bool loading = true;
  @override
  void initState() {
    SharedPreferenceHelper.getUserTokenSharedPreference()
        .then((value) => userToken = value!);
    SharedPreferenceHelper.getUserIDSharedPreference()
        .then((value) => userId = value!);
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        api.getAllNewsListForAdmin(userToken).then((value) => setState(() {
              newsModel = value;
              filterCategoryNews =
                  value.where((element) => element.approved == true).toList();
              loading = false;
            }));
      });
    });

    super.initState();
  }

  void changeTab(int index) {
    filterCategoryNews = newsModel
        .where((element) =>
            index == 0 ? element.approved == true : element.approved == false)
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/user.svg'),
          iconSize: 8.0,
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                        id: userId, token: userToken, isAdmin: true)));
          },
        ),
        title: Text(
          'News Admin Panel',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            iconSize: 24.0,
            color: Colors.white,
            onPressed: () async {
              await signOut();
              // print(userToken);
            },
          ),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: newsCategory.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                changeTab(index);
                              });
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0,
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: index == selectedIndex
                                          ? AppColors.primaryColor
                                          : AppColors.lightGreyBackground,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        newsCategory[index],
                                        style: TextStyle(
                                          color: index == selectedIndex
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ))),
                          );
                        },
                      ),
                    )),
                Expanded(
                  child: Container(
                    color: AppColors.lightGreyBackground,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        itemCount: filterCategoryNews.length,
                        itemBuilder: (BuildContext context, int index) =>
                            NewsCard(
                                news: filterCategoryNews[index], isAdmin: true),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateNewsScreen(
                        userToken: userToken,
                        userId: userId,
                      ))).then((value) => refresh());
        },
      ),
    );
  }

  void refresh() {
    api.getAllNewsListForAdmin(userToken).then((value) => setState(() {
          newsModel = value;
          filterCategoryNews =
              value.where((element) => element.approved == false).toList();
          loading = false;
        }));
    setState(() {});
  }

  signOut() {
    SharedPreferenceHelper.clearSharedPreferenceOnLogOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => InitializationScreen()));
  }
}
