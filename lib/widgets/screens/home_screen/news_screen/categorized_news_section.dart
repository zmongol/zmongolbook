import 'package:flutter/material.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/category_pills.dart';

import 'categorized_news_list.dart';

class CategorizedNewsSection extends StatelessWidget {
  final List<NewArticle> articles;
  final String categoryName;
  final ScrollController scrollController;
  final bool isLoading;

  const CategorizedNewsSection({
    Key? key,
    required this.articles,
    required this.categoryName,
    required this.scrollController,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0),
      height: 300,
      child:
          articles.isEmpty && isLoading ? _initialPlaceholder() : _newsList(),
    );
  }

  Widget _initialPlaceholder() {
    return Row(children: [
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
    ]);
  }

  Widget _newsList() {
    return ListView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      children: [
        CategoryPill(
          text: categoryName,
          isCenter: true,
        ),
        SizedBox(
          width: 16.0,
        ),
        CategorizedNewsList(
          articles: articles,
        ),
        isLoading
            ? Container(
                height: double.infinity,
                width: 100.0,
                alignment: Alignment.center,
                child: LoadingIndicator(),
              )
            : Container()
      ],
    );
  }
}
