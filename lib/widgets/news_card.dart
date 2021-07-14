import 'package:flutter/material.dart';
import 'package:localnews/models/NewsModel.dart';
import 'package:localnews/screens/news_details_screen.dart';
import 'package:localnews/styles/app_colors.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;
  final bool isAdmin;
  const NewsCard({Key? key, required this.news, required this.isAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      news.user.photo,
                      height: 25.0,
                      width: 25.0,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    news.user.firstName,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(news.photo),
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.all(16).copyWith(bottom: 0),
                child: Column(
                  children: [
                    Text(
                      news.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isAdmin && !news.approved
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                          news: news,
                                          isAdmin: true,
                                        )));
                          },
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
                      : TextButton(
                          child: Text('Read more'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                        news: news, isAdmin: false)));
                          },
                        ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: news.approved
                            ? AppColors.secondaryColor
                            : AppColors.primaryColor),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        news.approved ? 'Verified' : 'unVerified',
                        style: TextStyle(
                            color: news.approved ? Colors.white : Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
}
