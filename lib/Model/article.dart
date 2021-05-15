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
  final int priority;
  final int? categoryId;
  final String? imageUrl;
  final String? author;
  final String? websiteUrl;
  final DateTime? dateCreated;

  NewArticle.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        priority = json['priority'],
        categoryId = json['category'],
        imageUrl = json['image_url'],
        author = json['author'],
        websiteUrl = json['websiteUrl'],
        dateCreated = DateTime.tryParse(json['date_created']);
}
