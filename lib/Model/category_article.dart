

class CategoryArticle
{
  final String id;
  final String title;
  final String content;


  CategoryArticle(this.id,this.title,this.content);

  CategoryArticle.fromJson(Map<String,dynamic> json)
      : title=json['tittle'],
        content=json['content'],
        id=json['id'];

  String gettitle()
  {
    return title;
  }
}