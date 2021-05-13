import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mongol_ebook/Api%20Manager/api_manager.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/Model/news_category.dart';
import 'package:mongol_ebook/Model/top_article.dart';
import 'package:mongol_ebook/network/api_service.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/categorized_news_section.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/category_list.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/priority_news.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/top_stories.dart';

class NewsScreen extends StatefulWidget {
  static List categoryTitles = <dynamic>[];

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int categorySelected = 0;
  int currentPage = 0;
  String categoryName = '';

  NewArticle? priorityArticle;
  List<NewArticle> _topArticles = [];
  List<NewArticle> _categorizedArticles = [];
  List<NewsCategory> _categories = [];

  late ScrollController _controller;
  late ApiService _apiService;
  bool _isLoadingTopArticles = true;
  bool _isLoadingCategorizedNews = true;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _apiService = ApiService(Dio(), BASE_URL + ":8080");
    getTopArticles();
    loadCategories();
  }

  getTopArticles() async {
    _apiService.getTopStories().then(
          (articles) => {
            setState(() {
              _isLoadingTopArticles = false;
              priorityArticle = articles[0];
              _topArticles = articles..remove(priorityArticle);
            })
          },
        );
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      loadArticles();
    }
  }

  loadCategories() async {
    _apiService.getCategories().then((value) {
      setState(() {
        NewsScreen.categoryTitles =
            value.map((category) => category.toJson()).toList();
        _categories = value;
        categorySelected = _categories[0].id;
        categoryName = _categories[0].name;
        loadArticles();
      });
    });
  }

  loadArticles() async {
    _apiService
        .getArticles(categoryId: categorySelected, limit: 25, page: currentPage)
        .then((value) {
      setState(() {
        currentPage += 1;
        _isLoadingCategorizedNews = false;
        _categorizedArticles.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 24.0,
          ),
          _priorityNewsWidget(),
          SizedBox(
            height: 24.0,
          ),
          _topStoriesWidget(),
          SizedBox(
            height: 24.0,
          ),
          _categorizedNewsWidget(),
          SizedBox(
            height: 24.0,
          ),
          CategoryList(
            categories: _categories,
            setCategoryCallback: setCategory,
          ),
        ],
      ),
    );
  }

  Widget _priorityNewsWidget() {
    return !_isLoadingTopArticles
        ? PriorityNews(
            article: priorityArticle!,
            onTap: () => _openDetailPage(context, priorityArticle!.id),
          )
        : Container(
            height: 200.0,
            alignment: Alignment.center,
            child: LoadingIndicator(),
          );
  }

  Widget _topStoriesWidget() {
    return !_isLoadingTopArticles
        ? TopStories(
            articles: _topArticles,
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
          ]);
  }

  Widget _categorizedNewsWidget() {
    return !_isLoadingCategorizedNews
        ? CategorizedNewsSection(
            articles: _categorizedArticles, categoryName: categoryName)
        : Container(
            child: LoadingIndicator(),
            height: 200.0,
            alignment: Alignment.center,
          );
  }

  void _openDetailPage(BuildContext context, int id) {
    Navigator.of(context).pushNamed('/detail', arguments: {'index': id});
  }

  setCategory(NewsCategory category) {
    setState(() {
      categorySelected = category.id;
      categoryName = category.name;
      currentPage = 0;
      _categorizedArticles.clear();
      _isLoadingCategorizedNews = true;
      loadArticles();
    });
  }
}
