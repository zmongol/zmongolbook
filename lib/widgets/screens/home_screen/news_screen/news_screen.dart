import 'package:flutter/material.dart';
import 'package:mongol_ebook/Api%20Manager/api_manager.dart';
import 'package:mongol_ebook/Model/news_category.dart';
import 'package:mongol_ebook/Model/top_article.dart';
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
  String categorySelected = 'Category';
  String categoryName = '';

  TopArticle? priorityArticle;
  List<TopArticle> _topArticles = [];
  List<TopArticle> _categorizedArticles = [];
  List<NewsCategory> _categories = [];

  int offset = 0;
  late ScrollController _controller;
  bool _isLoadingTopArticles = true;
  bool _isLoadingCategorizedNews = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    getTopArticles();
    loadCategories();
  }

  getTopArticles() async {
    ApiManager.getTopArticles().then((value) {
      setState(() {
        _isLoadingTopArticles = false;
        priorityArticle = value[0];
        _topArticles = value..remove(priorityArticle);
      });
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      loadArticles();
    }
  }

  loadCategories() async {
    ApiManager.getCategoryTitle().then((value) {
      setState(() {
        NewsScreen.categoryTitles =
            value.map((category) => category.toJson()).toList();
        _categories = value;
        categorySelected = _categories[0].category;
        categoryName = _categories[0].categoryName;
        loadArticles();
      });
    });
  }

  loadArticles() async {
    ApiManager.getCategoryArticles(categorySelected, offset.toString())
        .then((value) {
      setState(() {
        offset = offset + 50;
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
            onTap: () => _openDetailPage(context, priorityArticle!.id),
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

  void _openDetailPage(BuildContext context, String id) {
    Navigator.of(context).pushNamed('/detail', arguments: {'index': id});
  }

  setCategory(NewsCategory category) {
    setState(() {
      categorySelected = category.category;
      categoryName = category.categoryName;
      offset = 0;
      _categorizedArticles.clear();
      _isLoadingCategorizedNews = true;
      loadArticles();
    });
  }
}
