import 'package:flutter/material.dart';
import 'package:mongol_ebook/Model/top_article.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/top_story.dart';

class TopStories extends StatelessWidget {
  final List<TopArticle> articles;
  final VoidCallback onTap;

  const TopStories({Key? key, required this.articles, required this.onTap})
      : super(key: key);

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
                  TopArticle article = articles[index];
                  return TopStory(
                    article: article,
                    onTap: onTap,
                  );
                },
                itemCount: articles.length,
              )
            : Container());
  }
}
