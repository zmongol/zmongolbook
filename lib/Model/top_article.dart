class TopArticle {
  final String id;
  final String title;
  final String content;

  TopArticle(this.id, this.title, this.content);

  TopArticle.fromJson(Map<String, dynamic> json)
      : title = json['tittle'],
        content = json['content'],
        id = json['id'];
}
