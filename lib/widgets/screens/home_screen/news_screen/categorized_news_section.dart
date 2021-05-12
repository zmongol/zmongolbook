import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';

import 'categorized_news_list.dart';

class CategorizedNewsSection extends StatelessWidget {
  final List<NewArticle> articles;
  final String categoryName;

  const CategorizedNewsSection(
      {Key? key, required this.articles, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16.0),
        height: 300,
        child: articles.isNotEmpty
            ? ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Center(
                    child: MongolText(
                      categoryName,
                      style: Theme.of(context).textTheme.headline2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  VerticalDivider(),
                  SizedBox(
                    width: 16.0,
                  ),
                  CategorizedNewsList(
                    articles: articles,
                  )
                ],
              )
            : Row(children: [
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: LoadingIndicator(),
                )),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: LoadingIndicator(),
                )),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: LoadingIndicator(),
                )),
              ]));
  }
}
