import 'package:dio/dio.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/Model/news_category.dart';

class ApiService {
  final Dio _dio;
  final String _baseUrl;

  ApiService(this._dio, this._baseUrl);

  Future<List<NewArticle>> getTopStories() async {
    var endpoint = _baseUrl + "/api/articles/priority";
    var response = await _dio.get(endpoint);
    var result = List<Map<String, dynamic>>.from(response.data["result"]);
    return result.map((json) => NewArticle.fromJson(json)).toList();
  }

  Future<List<NewArticle>> getArticles(
      {int categoryId = 0, int page = 0, int limit = 25}) async {
    var endpoint = _baseUrl + "/api/articles?page=$page&limit=$limit";
    print(endpoint);

    if (categoryId > 0) {
      endpoint = endpoint + "&categoryId=$categoryId";
    }

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
    var endpoint = _baseUrl + "/api/articles/$id";

    var response = await _dio.get(endpoint);
    var result = List<Map<String, dynamic>>.from(response.data["result"]);
    return NewArticle.fromJson(result[0]);
  }
}
