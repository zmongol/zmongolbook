import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/network/api_service.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/books_screen/book_widget.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  bool _isLoading = true;
  int _currentPage = 0;

  late ApiService _apiService;
  late ScrollController _scrollController;

  // Currently fetches list of articles
  List<NewArticle> _books = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        loadData();
      }
    });
    _apiService = ApiService(Dio(), BASE_URL + ":8080");
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1 / 2,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return BookWidget(
                  book: _books[index],
                );
              },
              itemCount: _books.length),
        ),
        _isLoading
            ? Center(
                child: LoadingIndicator(),
              )
            : Container(),
      ],
    );
  }

  loadData() async {
    _apiService.getArticles(limit: 50, page: _currentPage).then((articles) {
      setState(() {
        _currentPage++;
        _books.addAll(articles);
        _isLoading = false;
      });
    });
  }
}
