import 'package:localnews/models/CategoryModel.dart';
import 'package:localnews/models/UserModel.dart';

class NewsModel {
  int id;
  String created;
  String modified;
  String author;
  String title;
  String description;
  String photo;
  String websiteUrl;
  bool approved;
  CategoryModel category;
  UserModel user;

  NewsModel(
      {required this.id,
      required this.created,
      required this.modified,
      required this.author,
      required this.title,
      required this.description,
      required this.photo,
      required this.websiteUrl,
      required this.approved,
      required this.category,
      required this.user});

  NewsModel copyWith({
    required int id,
    required String created,
    required String modified,
    required String title,
    required String author,
    required String description,
    required String photo,
    required String websiteUrl,
    required bool approved,
    required CategoryModel category,
    required UserModel user,
  }) =>
      NewsModel(
          id: this.id,
          created: this.created,
          modified: this.modified,
          title: this.title,
          author: this.author,
          description: this.description,
          photo: this.photo,
          websiteUrl: this.websiteUrl,
          approved: this.approved,
          category: this.category,
          user: this.user);

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
      id: json["id"],
      created: json["created"],
      modified: json["modified"],
      author: json["author"],
      title: json["title"],
      description: json["description"],
      photo: json["photo"],
      websiteUrl: json["website_url"],
      approved: json["approved"],
      category: CategoryModel.fromMap(json["category"]),
      user: UserModel.fromMap(json['user']));

  Map<String, dynamic> toMap() => {
        "id": id,
        "created": created,
        "modified": modified,
        "author": author,
        "title": title,
        "description": description,
        "photo": photo,
        "website_url": websiteUrl,
        "approved": approved,
        "category": category,
        "user": user,
      };
}
