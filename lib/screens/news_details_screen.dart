import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localnews/data/api.dart';
import 'package:localnews/helper/SharedPreferences.dart';
import 'package:localnews/models/NewsModel.dart';
import 'package:localnews/styles/app_colors.dart';
import 'package:localnews/widgets/common/KDropDownButton.dart';
import 'package:localnews/widgets/common/KGradientButton.dart';
import 'package:localnews/widgets/common/KTextField.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsModel news;
  final bool isAdmin;
  NewsDetailScreen({Key? key, required this.news, required this.isAdmin})
      : super(key: key);

  @override
  _NewsDetailScreen createState() => _NewsDetailScreen();
}

class _NewsDetailScreen extends State<NewsDetailScreen> {
  String userToken = "";
  @override
  void initState() {
    SharedPreferenceHelper.getUserTokenSharedPreference()
        .then((value) => userToken = value!);
    super.initState();
  }

  final api = Api();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        title:
            Text(widget.news.user.firstName + " " + widget.news.user.lastName),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.news.user.photo,
                height: 18.0,
                width: 18.0,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.news.photo,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "News Reporter",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: AppColors.greyColor,
                      height: 1.4,
                    ),
                  ),
                  Text(
                    widget.news.author,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.titleTextColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Headline",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: AppColors.greyColor,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.news.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: AppColors.bigSubTitleTextColor),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Details",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: AppColors.greyColor,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.news.description,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColors.bigSubTitleTextColor),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              widget.isAdmin && !widget.news.approved
                  ? GestureDetector(
                      onTap: () {},
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          width: 120,
                          height: 40,
                          child: Text(
                            'Approve',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )))
                  : SizedBox(),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
            color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        api.approveNews(userToken, widget.news.id).then((value) => value
            ? Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context);
              })
            : print(value));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Alert",
        style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
      content: Text("Are You sure you want to approve this news "),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
