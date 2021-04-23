import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http ;
import 'package:mongol_ebook/Model/article.dart';

class ApiManager
{
  static Future<List<dynamic>> getTitle() async
  {
    HttpClient client = new HttpClient();

     var requestUrl = "http://18.141.10.41/read_api.php";

    HttpClientRequest request = await client.getUrl(Uri.parse(requestUrl));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();

    print("Response: "+reply.toString());
   List<dynamic> responseJson = json.decode(reply);

   print("JsonResponse: "+responseJson.toString());
    return responseJson;

  }

  static Future<Article> getData(String id) async
  {
     Uri uri = Uri.parse("http://18.141.10.41/get_data.php");
    var map = new Map<String, dynamic>();
    map['id'] = id;
    print("Content id: "+id);
    http.Response response = await http.post(
      uri,
      body: map,
    );

     final reply = await response.body.toString();

    print("Response: "+reply.toString());
    var responseJson = json.decode(reply);
    print("JsonResponse: "+responseJson.toString());

    var article = Article(responseJson[0]['garqag'],responseJson[0]['content']);
    return article;

  }

}