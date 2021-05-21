import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';
import 'package:url_launcher/url_launcher.dart';

class PageContent extends StatelessWidget {
  final NewArticle article;

  const PageContent({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String date = article.dateCreated != null
        ? formatter.format(article.dateCreated!)
        : '';

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
          child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(16),
              children: [
                    MongolText(
                      article.title,
                      style: AppSetting.instance.contentTextStyle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      children: [
                        MongolText(
                          date,
                          style: AppSetting.instance.contentTextStyle.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        MongolText(
                          article.author,
                          style: AppSetting.instance.contentTextStyle
                              .copyWith(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 24.0,
                    ),
                    VerticalDivider(
                      width: 1.0,
                      color: Colors.grey[400],
                    ),
                    SizedBox(
                      width: 24.0,
                    ),
                  ] +
                  _buildContent()),
        ),
      ),
    );
  }

  List<Widget> _buildContent() {
    if (article.contentHtml != null) {
      var doc = parseHtmlDocument(article.contentHtml!);
      return _buildFromHtml(doc);
    } else {
      return [
        MongolText(
          article.content,
          style: AppSetting.instance.contentTextStyle,
        ),
      ];
    }
  }

  List<Widget> _buildFromHtml(HtmlDocument? doc) {
    if (doc == null) {
      return [];
    }
    const margin = const SizedBox(
      width: 16.0,
    );
    List<Widget> list = [];
    var elems = doc.body!.children;
    elems.forEach((element) {
      if (element.toString().startsWith("<img")) {
        var imgSrc = element.attributes["src"];
        if (imgSrc != null) {
          list.add(margin);
          list.add(
            Image.network(
              imgSrc,
              height: double.infinity,
            ),
          );
        }
      } else if (element.toString().startsWith("<p")) {
        list.add(margin);
        list.add(
          MongolText(
            element.text,
            style: AppSetting.instance.contentTextStyle,
          ),
        );
      } else if (element.toString().startsWith("<a")) {
        var url = element.attributes["href"];
        var label = element.text;
        list.add(margin);
        list.add(_buildHyperlink(url: url!, text: label!));
      }
    });
    return list;
  }

  Widget _buildHyperlink({required String url, required String text}) {
    return InkWell(
        child: new MongolText(
          text,
          style: new TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () async {
          var validUrl = await canLaunch(url);
          if (validUrl) {
            await launch(url);
          }
        });
  }
}
