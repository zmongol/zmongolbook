import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';
import 'package:mongol_ebook/Model/article.dart';

class PageContent extends StatelessWidget {
  final NewArticle article;

  const PageContent({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppSetting.instance.contentBackgroundColor,
          ),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(16),
            child: MongolText(
              article.content,
              style: AppSetting.instance.contentTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
