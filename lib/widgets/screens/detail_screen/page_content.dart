import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';
import 'package:mongol_ebook/Helper/AppStyles.dart';
import 'package:mongol_ebook/Helper/RouteHelper.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/categorized_news.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/category_pills.dart';
import 'package:universal_html/html.dart' hide Navigator;
import 'package:universal_html/parsing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageContent extends StatelessWidget {
  final NewArticle article;
  final List<NewArticle> relatedArticles;
  final double pageWidth;
  final double pageHeight;

  const PageContent({
    Key? key,
    required this.article,
    required this.relatedArticles,
    required this.pageWidth,
    required this.pageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppSetting.instance.contentBackgroundColor,
          ),
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(32),
            children: _buildInfoSection() +
                _buildContent() +
                _buildRelatedArticlesSection(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInfoSection() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String date = article.dateCreated != null
        ? formatter.format(article.dateCreated!)
        : '';
    return [
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
          SizedBox(
            height: 24.0,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.remove_red_eye_outlined,
                  size: 24,
                  color: Colors.green[800],
                ),
              ),
              MongolText(
                article.viewCountMobile.toString() + " " + MONGOL_VIEWS,
                style: AppSetting.instance.contentTextStyle.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.green[800],
                ),
              )
            ],
          ),
        ],
      ),
      SizedBox(
        width: 16.0,
      ),
      Column(
        children: [
          article.source != null
              ? _source(source: article.source!)
              : Container(),
          article.newsCategory != null
              ? _categoryPill(text: article.newsCategory!.name)
              : Container(),
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        child: VerticalDivider(
          width: 1.0,
          color: Colors.grey[400],
        ),
      ),
    ];
  }

  Widget _categoryPill({required String text}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.green[300],
      ),
      child: MongolText(
        text,
        style: AppSetting.instance.contentTextStyle,
      ),
    );
  }

  Widget _source({required String source}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      child: MongolText(
        "ᡥᡬᢞᡪᢑᢙᡧ ᠄ " + source,
        style: AppSetting.instance.contentTextStyle.copyWith(color: Color(SOFT_BLACK)),
      ),
    );
  }

  List<Widget> _buildContent() {
    if (article.contentHtml != null) {
      var doc = parseHtmlDocument(article.contentHtml!
          .replaceAll(RegExp("<br>", caseSensitive: false), "\n"));
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

    List<Widget> list = [];
    var elems = doc.body!.children;
    elems.forEach((element) {
      var htmlElement = element as HtmlElement;
      list = list + _parseHtmlElement(htmlElement);
    });
    return list;
  }

  /// Method to build a single Widget along with left margin
  /// From a HTML Element
  List<Widget> _parseHtmlElement(HtmlElement element) {
    const margin = const SizedBox(
      width: 16.0,
    );

    List<Widget> list = [];

    if (element.children.length > 0) {
      element.children.forEach((child) {
        list = list + _parseHtmlElement(child as HtmlElement);
      });
    }

    if (element is ImageElement) {
      var imgSrc = element.src;
      if (imgSrc != null) {
        list.add(margin);
        list.add(_buildImage(imageUrl: imgSrc, width: pageWidth));
      }
    } else if (element is ParagraphElement) {
      list.add(margin);
      list.add(
        MongolText(
          element.text,
          style: AppSetting.instance.contentTextStyle,
        ),
      );
    } else if (element is AnchorElement) {
      var url = element.href;
      var label = element.text;
      list.add(margin);
      list.add(_buildHyperlink(url: url!, text: label ?? "Link"));
    } else if (element is IFrameElement) {
      var url = element.src ?? "";
      var width = element.width != null ? double.parse(element.width!) : 300.0;
      var height =
          element.height != null ? double.parse(element.height!) : 300.0;

      list.add(margin);
      list.add(
        _buildWebviewForIframe(
          url: url,
          width: width,
          height: height,
        ),
      );
    }

    return list;
  }

  /// Build image widget
  Widget _buildImage({required String imageUrl, required double width}) {
    return Builder(
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: pageHeight,
            maxWidth: pageWidth - 16,
          ),
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () =>
                RouteHelper.openViewImageScreen(context, imageUrl: imageUrl),
            child: Image.network(
              imageUrl,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// Build a hyperlink
  Widget _buildHyperlink({required String url, required String text}) {
    return InkWell(
        child: new MongolText(
          text,
          style: AppSetting.instance.contentTextStyle.copyWith(
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        onTap: () async {
          var validUrl = await canLaunch(url);
          if (validUrl) {
            await launch(url);
          }
        });
  }

  /// Show iframe with Webview
  Widget _buildWebviewForIframe(
      {required String url, required double width, required double height}) {
    var iframeHtml =
        "<html><body><iframe src='$url' width=$width height=$height></iframe></body></html>";
    var uri = Uri.dataFromString(iframeHtml, mimeType: 'text/html').toString();

    return Container(
        height: height,
        width: width,
        child: WebView(
          initialUrl: uri,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }

  List<Widget> _buildRelatedArticlesSection() {
    return relatedArticles.isNotEmpty
        ? [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: VerticalDivider(
                width: 1.0,
                color: Colors.grey[400],
              ),
            ),
            MongolText(
              MONGOL_RELATED_ARTICLES,
              style: AppSetting.instance.contentTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: Color(SOFT_BLACK),
              ),
            ),
            SizedBox(
              width: 24.0,
            ),
            ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var relatedArticle = relatedArticles[index];
                  return CategorizedNews(
                    imageSize: 120.0,
                    article: relatedArticle,
                    onTap: () => _openDetailPage(context, relatedArticle.id),
                  );
                },
                separatorBuilder: (_, index) => SizedBox(
                      width: 24.0,
                    ),
                itemCount: relatedArticles.length),
          ]
        : [];
  }

  _openDetailPage(context, id) {
    Navigator.of(context)
        .pushReplacementNamed('/detail', arguments: {'index': id});
  }
}
