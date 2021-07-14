import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:localnews/data/api_path.dart';
import 'package:localnews/data/exception.dart';
import 'package:localnews/helper/SharedPreferences.dart';
import 'package:localnews/models/CategoryModel.dart';
import 'package:localnews/models/NewsModel.dart';
import 'package:localnews/models/RegisterData.dart';
import 'package:http_parser/http_parser.dart';
import 'package:localnews/models/UserModel.dart';
import 'package:localnews/models/ValidateAdmin.dart';

class Api {
  final client = http.Client();
  final dio = Dio();

  Future login(String email, String password) async {
    try {
      final response = await client.post(Uri.parse(ApiPath.login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'email': email, 'password': password}));
      final decode = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPreferenceHelper.saveUserLoggedInSharedPreference(true);
        SharedPreferenceHelper.saveUserIDSharedPreference(
            decode['id'].toString());
        SharedPreferenceHelper.saveUserTokenSharedPreference(decode['access']);
        SharedPreferenceHelper.saveIsUserAdminSharedPreference(decode['admin']);
        return {'response': true, 'isAdmin': decode['admin']};
      } else {
        return {'response': false, 'isAdmin': false};
      }
    } catch (e) {
      rethrow;
    }
  }

  Future register(RegisterData data) async {
    try {
      final response = await client.post(Uri.parse(ApiPath.register),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toMap()));
      final decode = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>> getNewsList() async {
    final response = await client.get(
      Uri.parse(ApiPath.news),
      headers: {"accept": "application/json"},
    );

    final decoded = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return decoded['results']
          .map<NewsModel>((doc) => NewsModel.fromMap(doc))
          .toList();
    } else {
      throw AppException(msg: "Failed");
    }
  }

  Future<List<NewsModel>> getAllNewsListForAdmin(String token) async {
    print(token);
    final response = await client.get(
      Uri.parse(ApiPath.getAdminNews),
      headers: {"accept": "application/json", "Authorization": "Bearer $token"},
    );

    final decoded = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return decoded['results']
          .map<NewsModel>((doc) => NewsModel.fromMap(doc))
          .toList();
    } else {
      throw AppException(msg: "Failed");
    }
  }

  Future createNews(String token, String websiteUrl, String author,
      String title, String category, String description) async {
    print(token);
    final _request =
        http.MultipartRequest('POST', Uri.parse(ApiPath.newsCreate))
          ..fields['website_url'] = websiteUrl
          ..fields['author'] = author
          ..fields['title'] = title
          ..fields['category'] = category.toString()
          ..fields['description'] = description
          // ..files.add(await http.MultipartFile.fromPath('file', "filePath",
          //     contentType: MediaType('image', 'jpg/png')))
          /********************************************************* */
          //cannot PickImage using simmulator thats a problem in new
          //apple mac M1 (apple silicon) and xcode 14.5 but working fine
          //on actual device
          /********************************************************* */
          ..headers['Authorization'] = "Bearer $token";
    var result = await _request.send();
    var response = http.Response.fromStream(result).then((res) {
      print(res.statusCode);
      if (res.statusCode == 201) {
        print('true');
        return true;
      } else {
        print('false');
        return false;
      }
    });
    return response;
  }

  Future<UserModel> userProfile(String id, String token) async {
    final response = await client.get(Uri.parse(ApiPath.userProfile), headers: {
      "accept": "application/json",
      "Authorization": "Bearer $token"
    });
    final decoded = jsonDecode(response.body);
    print(decoded);
    if (response.statusCode == 200) {
      return UserModel.fromMap(decoded);
    } else {
      throw AppException(msg: "Failed");
    }
  }

  Future<List<CategoryModel>> getNewsCategoryList(String token) async {
    final response = await client.get(
      Uri.parse(ApiPath.getNewscategories),
      headers: {"accept": "application/json", "Authorization": "Bearer $token"},
    );

    final decoded = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return decoded['results']
          .map<CategoryModel>((doc) => CategoryModel.fromMap(doc))
          .toList();
    } else {
      throw AppException(msg: "No Data");
    }
  }

  Future<List<NewsModel>> getPersonalNewsList(String token) async {
    final response = await client.get(
      Uri.parse(ApiPath.getPersonalNewsList),
      headers: {"accept": "application/json", 'Authorization': 'Bearer $token'},
    );

    final decoded = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return decoded['results']
          .map<NewsModel>((doc) => NewsModel.fromMap(doc))
          .toList();
    } else {
      throw AppException(msg: "No Data");
    }
  }

  //As http not accept boolean value in body so i have to use dio just for
  // this specific Api.
  Future approveNews(String token, int id) async {
    final response = await dio.patch(ApiPath.getAdminNews + '$id',
        data: FormData.fromMap({'approved': true}),
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
