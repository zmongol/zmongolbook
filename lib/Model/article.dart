import 'package:mongol_ebook/Model/news_category.dart';

class Article {
  final String title;
  final String content;

  Article(this.title, this.content);

  Article.fromJson(Map<String, dynamic> json)
      : title = json['garqag'],
        content = json['content'];

  String getContent() {
    return content;
  }
}

class NewArticle {
  final int id;
  final String title;
  final String? content;
  final String? contentHtml;
  final int priority;
  final int? categoryId;
  final NewsCategory? newsCategory;
  final String? imageUrl;
  final String? author;
  final String? websiteUrl;
  final DateTime? dateCreated;
  final int viewCount;
  final int viewCountMobile;

  NewArticle.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        contentHtml = json['content_html'],
        priority = json['priority'],
        categoryId = json['category'],
        newsCategory = json['category_object'] != null
            ? NewsCategory.fromJson(json['category_object'])
            : null,
        imageUrl = json['image_url'],
        author = json['author'],
        websiteUrl = json['websiteUrl'],
        dateCreated = DateTime.tryParse(json['date_created']),
        viewCount = json['view_count'] ?? 0,
        viewCountMobile = json['view_count_mobile'] ?? 0;
}
