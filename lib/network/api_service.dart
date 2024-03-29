import 'package:dio/dio.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/Model/auth/login_result.dart';
import 'package:mongol_ebook/Model/auth/register_result.dart';
import 'package:mongol_ebook/Model/news_category.dart';
import 'package:mongol_ebook/Model/version_check/app_version_check.dart';

class ApiService {
  final Dio _dio;
  final String _baseUrl;

  ApiService(this._dio, this._baseUrl) {
    // Default headers
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['X-API-Key'] = "b25fa5fe-432d-442f-8f1f-55e8e89aedea";
          return handler.next(options);
        },
      ),
    );
  }

  Future<AppVersionCheck?> getLatestAppVersion() async {
    var endpoint = _baseUrl + "/api/version-check";

    try {
      var response = await _dio.get(endpoint);
      return AppVersionCheck.fromJson(response.data["result"]);
    } on Error {
      return null;
    }
  }

  Future<RegisterResult> register(String username, String password,
      String email, String firstName, String? lastName) async {
    var endpoint = _baseUrl + "/api/auth/register";
    try {
      await _dio.post(endpoint, data: {
        "username": username,
        "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
      });
    } on DioError catch (e) {
      String? errorMsg =
          e.response != null ? e.response!.data["result"] : e.message;
      return RegisterResult(false, errorMsg);
    }

    return RegisterResult(true, null);
  }

  Future<LoginResult> login(String username, String password) async {
    var endpoint = _baseUrl + "/api/auth/login";
    try {
      var response = await _dio.post(endpoint, data: {
        "username": username,
        "password": password,
      });

      return LoginResult(true, accessToken: response.data["result"]["token"]);
    } on DioError catch (e) {
      var errorMsg;
      if (e.response != null) {
        errorMsg = e.response!.data["result"];
      } else {
        errorMsg = e.message;
      }
      return LoginResult(false, errorMessage: errorMsg);
    }
  }

  Future<List<NewArticle>> getTopStories() async {
    var endpoint = _baseUrl + "/api/articles/priority";
    var response = await _dio.get(endpoint);
    var result = List<Map<String, dynamic>>.from(response.data["result"]);
    return result.map((json) => NewArticle.fromJson(json)).toList();
  }

  Future<List<NewArticle>> getArticles(
      {int categoryId = 0, int page = 0, int limit = 25, String? title}) async {
    var endpoint = _baseUrl + "/api/articles?page=$page&limit=$limit";

    if (categoryId > 0) {
      endpoint = endpoint + "&categoryId=$categoryId";
    }

    if (title != null) {
      endpoint = endpoint + "&title=$title";
    }

    print(endpoint);

    var response = await _dio.get(endpoint);
    var result = List<Map<String, dynamic>>.from(response.data["result"]);
    return result.map((json) => NewArticle.fromJson(json)).toList();
  }

  Future<List<NewsCategory>> getCategories() async {
    var endpoint = _baseUrl + "/api/categories";

    var response = await _dio.get(endpoint);
    var result = List<Map<String, dynamic>>.from(response.data["result"]);
    return result.map((json) => NewsCategory.fromJson(json)).toList();
  }

  Future<NewArticle> findArticleById(int id) async {
    var endpoint = _baseUrl + "/api/articles/$id?source=mobile";

    var response = await _dio.get(endpoint);
    var result = List<Map<String, dynamic>>.from(response.data["result"]);
    return NewArticle.fromJson(result[0]);
  }

  Future<List<NewArticle>> getRelatedArticles(int id) async {
    var endpoint = _baseUrl + "/api/articles/related/$id";

    var response = await _dio.get(endpoint);
    var result = List<Map<String, dynamic>>.from(response.data["result"]);

    return result.map((json) => NewArticle.fromJson(json)).toList();
  }
}
