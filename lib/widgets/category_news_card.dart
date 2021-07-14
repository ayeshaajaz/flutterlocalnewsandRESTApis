import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localnews/models/NewsModel.dart';
import 'package:localnews/screens/news_details_screen.dart';
import 'package:localnews/styles/app_colors.dart';

class CategoryNewsCard extends StatelessWidget {
  final NewsModel news;
  const CategoryNewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(
                        news: news,
                        isAdmin: false,
                      )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: 124,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.09),
                  blurRadius: 20,
                  spreadRadius: 3.5,
                  offset: Offset(0, 13)),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 100,
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: news.approved
                              ? AppColors.secondaryColor
                              : Color(0xffD6D6D6).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        news.approved ? "Verified" : 'unVerified',
                        style: GoogleFonts.cabin(
                          textStyle: TextStyle(
                              color: news.approved
                                  ? Colors.white
                                  : Colors.grey[400],
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            news.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cabin(
                                textStyle: TextStyle(
                                    color: Color(0xff243358),
                                    fontWeight: FontWeight.bold),
                                fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            news.user.firstName,
                            style: GoogleFonts.cabin(
                              textStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 11,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Flexible(
                flex: 4,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(news.photo))),
                ),
              )
            ],
          ),
        ));
  }
}
