import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localnews/styles/app_colors.dart';
import 'package:localnews/widgets/common/SearchBar.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Container(
          child: SearchBar(
            hintText: 'Search . . .',
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.iconColorDark,
            ),
            suffixIcon: IconButton(
                onPressed: () {},
                icon: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/images/filter.svg',
                    height: 24,
                    width: 24,
                  ),
                )),
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.search,
            controller: searchController,
            submitted: (val) => {},
            textStyle: TextStyle(
              color: AppColors.titleTextColor,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            hintTextStyle: TextStyle(
              color: AppColors.subTitleTextColor,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
