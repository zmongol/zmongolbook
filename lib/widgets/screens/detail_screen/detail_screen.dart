import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/network/api_service.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import './page_content.dart';
import 'package:share/share.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  DetailScreen(this.id);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService(Dio(), BASE_URL + ":8080");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 40,
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  Share.share("http://Zmongol/detail/${widget.id}");
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.share,
                    color: Colors.black,
                    size: 25,
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
    return FutureBuilder<NewArticle>(
        future: _apiService.findArticleById(widget.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return LoadingIndicator();
              }
            case ConnectionState.done:
              {
                print("Opening article with ID: " + widget.id.toString());
                if (snapshot.data != null) {
                  return PageContent(
                    article: snapshot.data!,
                  );
                }
                break;
              }
            default:
              return Container();
          }
          return Container();
        });
  }
}
