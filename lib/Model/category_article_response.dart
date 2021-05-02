import 'package:mongol_ebook/Model/category_article.dart';

class CategoryArticleResponse {
  final List<CategoryArticle> list;

  CategoryArticleResponse({
    required this.list,
  });

  factory CategoryArticleResponse.fromJson(List<dynamic> parsedJson) {
    List<CategoryArticle> list = <CategoryArticle>[];
    list = parsedJson.map((i) => CategoryArticle.fromJson(i)).toList();

    return new CategoryArticleResponse(list: list);
  }
}