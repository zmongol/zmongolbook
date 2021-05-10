import 'package:flutter/material.dart';
import 'package:mongol_ebook/Model/top_article.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/categorized_news.dart';

class CategorizedNewsList extends StatelessWidget {
  final List<TopArticle> articles;

  const CategorizedNewsList({Key? key, required this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (_, index) => SizedBox(width: 20.0),
      itemBuilder: (_, index) {
        TopArticle article = articles[index];
        return CategorizedNews(
          article: article,
          onTap: () => _openDetailPage(context, article.id),
        );
      },
      itemCount: articles.length,
    );
  }

  _openDetailPage(context, id) {
    Navigator.of(context).pushNamed('/detail', arguments: {'index': id});
  }
}
