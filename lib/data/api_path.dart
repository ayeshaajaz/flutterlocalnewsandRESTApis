import 'package:localnews/utils/Constants.dart';

class ApiPath {
  // Auth Api
  static String get register =>
      '${Constants.BASE_URL}/api/v1.0/user_service/users/';
  static String get login =>
      '${Constants.BASE_URL}/api/v1.0/auth_service/token/create/';

  static String get news =>
      '${Constants.BASE_URL}/api/v1.0/news_services/article/';

  static String get newsCreate =>
      '${Constants.BASE_URL}/api/v1.0/news_services/article/';

  static String get userProfile =>
      '${Constants.BASE_URL}/api/v1.0/user_service/users/me/';

  static String get getPersonalNewsList =>
      '${Constants.BASE_URL}/api/v1.0/news_services/user_article/';

  //admin can get approve and pending News
  //admin can also approve the news request with the same Api by sending newsId
  static String get getAdminNews =>
      '${Constants.BASE_URL}/api/v1.0/news_services/admin_article/';

  static String get getNewscategories =>
      '${Constants.BASE_URL}/api/v1.0/news_services/category/';

  //for admin only and pass category name as parameter
  static String get addNewscategory =>
      '${Constants.BASE_URL}/api/v1.0/news_services/category/';
}
