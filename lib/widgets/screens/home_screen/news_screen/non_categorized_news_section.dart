import 'package:flutter/material.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';

import 'categorized_news_list.dart';
import 'category_pills.dart';

class NonCategorizedNewsSection extends StatelessWidget {
  static const LABEL_LATEST_NEWS = "ᢔᡬᡰᡨ ᢌᡪᢙᡪᢊᡪᡨ";
  final List<NewArticle> articles;
  final ScrollController scrollController;
  final bool isLoading;

  const NonCategorizedNewsSection({
    Key? key,
    required this.articles,
    required this.scrollController,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0),
      height: 300,
      child: articles.isEmpty && isLoading
          ? _initialPlaceholder()
          : _newsList(context),
    );
  }

  Widget _initialPlaceholder() {
    return Row(
      children: [
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
      ],
    );
  }

  Widget _newsList(BuildContext context) {
    return ListView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      children: [
        CategoryPill(
          text: LABEL_LATEST_NEWS,
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
