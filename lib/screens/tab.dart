import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:localnews/helper/SharedPreferences.dart';
import 'package:localnews/screens/create_news_screen.dart';
import 'package:localnews/screens/home_screen.dart';
import 'package:localnews/screens/profile_screen.dart';
import 'package:localnews/screens/search_screen.dart';
import 'package:localnews/screens/categories_screen.dart';
import 'package:localnews/styles/app_colors.dart';

class TabScreen extends StatefulWidget {
  TabScreen({
    Key? key,
  }) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  String userToken = "";
  String userId = "";
  bool isAdmin = false;
  @override
  void initState() {
    super.initState();
    SharedPreferenceHelper.getUserTokenSharedPreference()
        .then((value) => userToken = value!);
    SharedPreferenceHelper.getUserIDSharedPreference()
        .then((value) => userId = value!);
    SharedPreferenceHelper.getIsUserAdminSharedPreference()
        .then((value) => isAdmin = value!);
  }

  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(userToken: ""),
    SearchScreen(),
    ProfileScreen(
      id: '',
      token: "",
      isAdmin: false,
    )
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
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
                      )));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home,
                            color: currentTab == 0
                                ? AppColors.primaryColor
                                : Colors.grey),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab == 0
                                  ? AppColors.primaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = CategoryScreen(userToken: userToken);
                        currentTab = 1;
                      });
                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.category,
                            color: currentTab == 1
                                ? AppColors.primaryColor
                                : Colors.grey),
                        Text(
                          'Categories',
                          style: TextStyle(
                              color: currentTab == 1
                                  ? AppColors.primaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = SearchScreen();
                        currentTab = 2;
                      });
                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search,
                            color: currentTab == 2
                                ? AppColors.primaryColor
                                : Colors.grey),
                        Text(
                          'Search',
                          style: TextStyle(
                              color: currentTab == 2
                                  ? AppColors.primaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfileScreen(
                          id: userId,
                          token: userToken,
                          isAdmin: isAdmin,
                        );
                        currentTab = 3;
                      });
                    },
                    minWidth: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.account_circle,
                            color: currentTab == 3
                                ? AppColors.primaryColor
                                : Colors.grey),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: currentTab == 3
                                  ? AppColors.primaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
