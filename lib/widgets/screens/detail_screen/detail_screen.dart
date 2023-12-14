import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Helper/AppStyles.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/network/api_service.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:share_plus/share_plus.dart';

import './page_content.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  DetailScreen(this.id);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ApiService _apiService;
  NewArticle? _article;
  List<NewArticle>? _relatedArticles;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService(Dio(), BASE_URL);

    _apiService.findArticleById(widget.id).then((article) {
      setState(() {
        print("Fetched article with ID: " + widget.id.toString());
        _article = article;
      });
    });

    _apiService.getRelatedArticles(widget.id).then((articles) {
      setState(() {
        _relatedArticles = articles;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "ZmongolBook",
              style: APP_BAR_TITLE_STYLE.copyWith(fontSize: 28),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await Navigator.of(context).pushNamed('/setting');
                  setState(() {});
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Share.share("$BASE_URL/zmongolbook?articleId=${widget.id}");
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: _pageContent(),
        ),
      ),
    );
  }

  Widget _pageContent() {
    var deviceSize = MediaQuery.of(context).size;
    return _article != null && _relatedArticles != null
        ? PageContent(
            article: _article!,
            relatedArticles: _relatedArticles!,
            pageWidth: deviceSize.width,
            pageHeight: deviceSize.height,
          )
        : LoadingIndicator();
  }
}
