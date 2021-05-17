import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/network/api_service.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/books_screen/book_widget.dart';
import 'package:mongol_ebook/extensions/scroll_controller_extension.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  static const PAGE_SIZE = 20;
  bool _isLoading = true;
  int _currentPage = 0;

  late ApiService _apiService;
  late ScrollController _scrollController;
  final formatter = DateFormat('yyyy-MM-dd');

  // Currently fetches list of articles
  List<NewArticle> _books = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.isEndOfPage() && !_isLoading) {
        setState(() {
          _isLoading = true;
          loadData();
        });
      }
    });
    _apiService = ApiService(Dio(), BASE_URL);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        controller: _scrollController,
        children: [
          ClipRRect(
            // borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
                "https://i.guim.co.uk/img/media/77e3e93d6571da3a5d77f74be57e618d5d930430/0_0_2560_1536/master/2560.jpg?width=1300&quality=45&auto=format&fit=max&dpr=2&s=3dfa0308ea70c0afa873298b3f505ec1",
                fit: BoxFit.cover,
                height: 160.0,
                width: double.infinity),
          ),
          _newBooksList(),
          _isLoading
              ? Container(
                  child: LoadingIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _newBooksList() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0,
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _books.length,
        itemBuilder: (context, index) {
          var book = _books[index];
          String date = book.dateCreated != null
              ? formatter.format(book.dateCreated!)
              : '';

          return GestureDetector(
            onTap: () => _openDetailPage(context, book.id),
            child: Container(
              height: 180.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 12.0,
                      spreadRadius: 2.0,
                      offset: Offset(0, 5)),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      book.id % 2 == 0
                          ? "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1348322381l/3450744.jpg"
                          : "https://m.media-amazon.com/images/I/41k+WVPLwZL.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: 120,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MongolText(
                            book.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline2!,
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          MongolText(
                            book.content,
                            maxLines: 4,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              MongolText(
                                book.author!,
                                style: TextStyle(fontFamily: 'haratig'),
                              ),
                              Spacer(),
                              MongolText(
                                date,
                                style: TextStyle(fontFamily: 'haratig'),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: double.infinity,
                            child: MongolText(
                              "4.5/5",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'haratig',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 24.0);
        },
      ),
    );
  }

  // Old version of the UI
  Widget _oldBooksGrid() {
    return GridView.builder(
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
        itemCount: _books.length);
  }

  loadData() async {
    _apiService
        .getArticles(limit: PAGE_SIZE, page: _currentPage)
        .then((articles) {
      setState(() {
        _currentPage++;
        _books.addAll(articles);
        _isLoading = false;
      });
    });
  }

  void _openDetailPage(BuildContext context, int id) {
    Navigator.of(context).pushNamed('/detail', arguments: {'index': id});
  }
}
