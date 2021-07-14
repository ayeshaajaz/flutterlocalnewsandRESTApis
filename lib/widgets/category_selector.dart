import 'package:flutter/material.dart';
import 'package:localnews/models/CategoryModel.dart';
import 'package:localnews/styles/app_colors.dart';

class CategorySelector extends StatefulWidget {
  final List<CategoryModel> categories;
  final Function callBack;

  const CategorySelector(
      {Key? key, required this.categories, required this.callBack})
      : super(key: key);
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: AppColors.primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                widget.callBack(widget.categories[index].name);
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Text(
                widget.categories[index].name,
                style: TextStyle(
                  color: index == selectedIndex ? Colors.white : Colors.white60,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
