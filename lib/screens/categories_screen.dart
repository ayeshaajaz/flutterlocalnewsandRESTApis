import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localnews/data/api.dart';
import 'package:localnews/models/CategoryModel.dart';
import 'package:localnews/models/NewsModel.dart';
import 'package:localnews/styles/app_colors.dart';
import 'package:localnews/widgets/category_news_card.dart';
import 'package:localnews/widgets/category_selector.dart';

class CategoryScreen extends StatefulWidget {
  final String userToken;
  CategoryScreen({Key? key, required this.userToken}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final api = Api();
  List<CategoryModel> categoryModel = [];
  List<NewsModel> newsModel = [];
  String selectedCategory = "politics";

  List<NewsModel> filterCategoryNews = [];

  @override
  void initState() {
    api.getNewsCategoryList(widget.userToken).then((value) => setState(() {
          categoryModel = value;
        }));

    api.getNewsList().then((value) => setState(() {
          newsModel = value;
          filterCategoryNews = value
              .where((element) => element.category.name
                  .toLowerCase()
                  .contains(selectedCategory))
              .toList();
        }));
    super.initState();
  }

  onSelectcategory(String val) {
    filterCategoryNews.clear();
    if (filterCategoryNews.isEmpty) {
      setState(() {});
    }
    filterCategoryNews = newsModel
        .where((element) => element.category.name.toLowerCase().contains(val))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Category',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset('assets/images/user.svg'),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelector(
              categories: categoryModel, callBack: onSelectcategory),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 24, left: 8, right: 8),
                child: ListView.builder(
                  itemCount: filterCategoryNews.length,
                  itemBuilder: (BuildContext context, int index) =>
                      CategoryNewsCard(
                    news: filterCategoryNews[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
