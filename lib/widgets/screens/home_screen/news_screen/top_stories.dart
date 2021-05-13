import 'package:flutter/material.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/Model/top_article.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/top_story.dart';

class TopStories extends StatelessWidget {
  final List<NewArticle> articles;

  const TopStories({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0),
      height: TopStory.height,
      child: articles.isNotEmpty
          ? ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, index) => SizedBox(width: 20.0),
              itemBuilder: (_, index) {
                var article = articles[index];
                return TopStory(
                  article: article,
                  onTap: () => _openDetailPage(context, article.id),
                );
              },
              itemCount: articles.length,
            )
          : Container(),
    );
  }

  void _openDetailPage(BuildContext context, int id) {
    Navigator.of(context).pushNamed('/detail', arguments: {'index': id});
  }
}
