
class Article
{
  final String title;
  final String content;


  Article(this.title,this.content);

  Article.fromJson(Map<String,dynamic> json)
  : title=json['garqag'],
    content=json['content'];

  String getContent()
  {
    return content;
  }
}