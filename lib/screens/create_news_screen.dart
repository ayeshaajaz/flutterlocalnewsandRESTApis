import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localnews/data/api.dart';
import 'package:localnews/helper/SharedPreferences.dart';
import 'package:localnews/styles/app_colors.dart';
import 'package:localnews/widgets/common/KDropDownButton.dart';
import 'package:localnews/widgets/common/KGradientButton.dart';
import 'package:localnews/widgets/common/KTextField.dart';

class CreateNewsScreen extends StatefulWidget {
  final String userToken;
  final String userId;
  CreateNewsScreen({Key? key, required this.userToken, required this.userId})
      : super(key: key);

  @override
  _CreateNewsScreenState createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  String userToken = "";
  final _headLineController = TextEditingController();
  final _newsDetailController = TextEditingController();
  final _authorController = TextEditingController();

  String get title => _headLineController.text.trim();
  String get description => _newsDetailController.text.trim();
  String get author => _newsDetailController.text.trim();

  final _picker = ImagePicker();
  File? _image;
  var _category = [
    'Politics',
    'Sports',
    'Weather',
    'WildLife',
    "Health & Fitness",
    "Fashion",
    "Social",
    "Community"
  ];
  int category = 1;
  String _selectedCategory = "Politics";
  final api = Api();

  @override
  void initState() {
    SharedPreferenceHelper.getIsUserAdminSharedPreference()
        .then((value) => {print(value)});
    print(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 16, color: AppColors.textTileColor);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Add News"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 6,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 150,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () async {
                      /********************************************************* */
                      //cannot PickImage using simmulator thats a problem in new
                      //apple mac M1 (apple silicon) and xcode 14.5 but working fine
                      //on actual device (physical device)
                      /********************************************************* */
                      final _pickedImage = await ImagePicker()
                          .getImage(source: ImageSource.gallery);

                      if (_pickedImage != null) {
                        setState(() {
                          _image = File(_pickedImage.path);
                        });
                      }
                      print(_image);
                    },
                    child: DottedBorder(
                      dashPattern: [10],
                      strokeCap: StrokeCap.round,
                      strokeWidth: 1.2,
                      borderType: BorderType.RRect,
                      color: AppColors.gradientColorB,
                      radius: Radius.circular(8),
                      child: Container(
                        child: _image != null
                            ? Image.file(_image!, fit: BoxFit.cover)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/plus.svg',
                                    color: AppColors.gradientColorB,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Select your Media File for News by \n clicking here..',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.gradientColorB,
                                      fontSize: 15,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                        height: 168,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Enter your News Headline', style: titleStyle),
                SizedBox(height: 8),
                KTextField(
                    hintText: "Weather Forecast e.g...",
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.newline,
                    controller: _headLineController,
                    hintTextStyle: TextStyle(
                      color: AppColors.subTitleTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    textStyle: TextStyle(
                      color: Color(0xff636C79),
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 1,
                    hasFocus: false),
                const SizedBox(height: 4),
                SizedBox(height: 16),
                Text('Select Your News Category', style: titleStyle),
                SizedBox(height: 8),
                KDropdownButton(
                    label: "Politics",
                    options: _category,
                    value: _selectedCategory,
                    onChanged: _onSelectCategory),
                SizedBox(height: 16),
                Text('Detail', style: titleStyle),
                SizedBox(height: 8),
                Container(
                  child: KTextField(
                    maxLines: 10,
                    controller: _newsDetailController,
                    hintText: 'Write Down Your Notes here...',
                    textInputType: TextInputType.multiline,
                    textStyle: TextStyle(
                      color: Color(0xff636C79),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    hintTextStyle: TextStyle(
                      color: AppColors.subTitleTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    hasFocus: false,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(height: 24),
                KGradientButton(
                    title: "Submit",
                    width: MediaQuery.of(context).size.width * 0.5,
                    onPress: () async {
                      submit(context);
                    },
                    textColor: Colors.white),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Discard News',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: AppColors.buttonTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSelectCategory(dynamic val) {
    _selectedCategory = val;
    if (_selectedCategory == "Community") {
      category = 8;
    } else if (_selectedCategory == "Social") {
      category = 7;
    } else if (_selectedCategory == "Fashion") {
      category = 6;
    }
    if (_selectedCategory == "Health & Fitness") {
      category = 5;
    } else if (_selectedCategory == "WildLife") {
      category = 4;
    } else if (_selectedCategory == "Weather") {
      category = 3;
    } else if (_selectedCategory == "Sports") {
      category = 2;
    } else if (_selectedCategory == "Politics") {
      category = 1;
    }
    setState(() {});
  }

  void submit(BuildContext context) {
    if (title == "" || author == "" || description == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All fields Require'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      api
          .createNews(widget.userToken, "", author, title, category.toString(),
              description)
          .then((value) => value
              ? showAlertDialog(context)
              : ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error! Please try to Post again. '),
                    backgroundColor: Colors.red,
                  ),
                ));
    }
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
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Note",
        style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
      content: Text(
          "Your News will be sent to the admin of this app for Review and Approval. It will be available after 24 hours. "),
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
