import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/Model/news_category.dart';
import 'package:mongol_ebook/Model/top_article.dart';

class ApiManager {
  static Future<List<dynamic>> getTitle() async {
    HttpClient client = new HttpClient();

    var requestUrl = BASE_URL + "/read_api.php";

    HttpClientRequest request = await client.getUrl(Uri.parse(requestUrl));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();

    print("Response: " + reply.toString());
    List<dynamic> responseJson = json.decode(reply);

    print("JsonResponse: " + responseJson.toString());
    return responseJson;
  }

  static Future<Article> getData(String id) async {
    Uri uri = Uri.parse(BASE_URL + "get_data.php");
    var map = new Map<String, dynamic>();
    map['id'] = id;
    print("Content id: " + id);
    http.Response response = await http.post(
      uri,
      body: map,
    );

    final reply = response.body.toString();

    print("Response: " + reply.toString());
    var responseJson = json.decode(reply);
    print("JsonResponse: " + responseJson.toString());

    var article =
        Article(responseJson[0]['garqag'], responseJson[0]['content']);
    return article;
  }

  static Future<String> signUp(String username, String email, String pass,
      String confirmPass, String mobileNo) async {
    Uri uri = Uri.parse(BASE_URL + "signup.php"); /**/
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['email'] = email;
    map['password'] = pass;
    map['cnfrm_password'] = confirmPass;
    map['mobile_no'] = mobileNo;

    print("Signup: " + map.toString());
    http.Response response = await http.post(
      uri,
      body: map,
    );

    final reply = response.body.toString();

    print("Response: " + reply.toString());

    return reply;
  }

  static Future<String> logIn(String username, String pass) async {
    Uri uri = Uri.parse(BASE_URL + "login.php");
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = pass;

    http.Response response = await http.post(
      uri,
      body: map,
    );

    final reply = response.body.toString();

    print("Response: " + reply.toString());

    return reply;
  }

  static Future<List<NewsCategory>> getCategoryTitle() async {
    HttpClient client = new HttpClient();

    var requestUrl = BASE_URL + "category_table.php";

    HttpClientRequest request = await client.getUrl(Uri.parse(requestUrl));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();

    var jsonArray = List<Map<String, dynamic>>.from(json.decode(reply));
    List<NewsCategory> categories =
        jsonArray.map((json) => NewsCategory.fromJson(json)).toList();

    return categories;
  }

  static Future<List<TopArticle>> getCategoryArticles(
      String category, String offset) async {
    Uri uri = Uri.parse(BASE_URL + "get_category.php");
    var map = new Map<String, dynamic>();
    map['category'] = category;
    map['offset'] = offset;

    http.Response response = await http.post(
      uri,
      body: map,
    );

    final reply = response.body.toString();
    final jsonDecoded = json.decode(reply);

    if (jsonDecoded == null) {
      return [];
    }

    final jsonArray = List<Map<String, dynamic>>.from(jsonDecoded);

    List<TopArticle> articles =
        jsonArray.map((json) => TopArticle.fromJson(json)).toList();

    return articles;
  }

  static Future<List<TopArticle>> getTopArticles() async {
    HttpClient client = new HttpClient();

    var requestUrl = BASE_URL + "priority.php";

    HttpClientRequest request = await client.getUrl(Uri.parse(requestUrl));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();

    final jsonArray = List<Map<String, dynamic>>.from(json.decode(reply));

    List<TopArticle> articles =
        jsonArray.map((json) => TopArticle.fromJson(json)).toList();

    return articles;
  }

  static Future<String> sendToken(String username, String fcmToken) async {
    Uri uri = Uri.parse(BASE_URL + "fcm_token.php");
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['token'] = fcmToken;

    http.Response response = await http.post(
      uri,
      body: map,
    );

    final reply = response.body.toString();

    print("Response: " + reply.toString());

    return reply;
  }
}
