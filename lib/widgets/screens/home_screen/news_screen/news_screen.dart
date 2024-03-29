import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/Model/news_category.dart';
import 'package:mongol_ebook/Utils/dialog_utils.dart';
import 'package:mongol_ebook/network/api_service.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/categorized_news_section.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/category_list.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/non_categorized_news_section.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/priority_news.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/top_stories.dart';
import 'package:mongol_ebook/extensions/scroll_controller_extension.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NewsScreen extends StatefulWidget {
  static List categoryTitles = <dynamic>[];

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  static const CATEGORIZED_NEWS_PAGE_SIZE = 25;

  int categorySelected = 0;
  int currentPage = 0;
  int currentPageNonCategorized = 0;
  String categoryName = '';

  NewArticle? priorityArticle;
  List<NewArticle> _topArticles = [];
  List<NewArticle> _categorizedArticles = [];
  List<NewArticle> _nonCategorizedArticles = []; // For tablets
  List<NewsCategory> _categories = [];

  late ScrollController _controller;
  late ScrollController _nonCategorizedArticlesController;
  late ApiService _apiService;
  bool _isLoadingTopArticles = true;
  bool _isLoadingCategorizedNews = true;
  bool _isLoadingNonCategorizedArticles = true;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.isEndOfPage() && !_isLoadingCategorizedNews) {
        setState(() {
          _isLoadingCategorizedNews = true;
          loadArticles();
        });
      }
    });
    _apiService = ApiService(Dio(), BASE_URL);
    getLatestAppVersion();
    getTopArticles();
    loadCategories();
    initializeNonCategorizedNews();
  }

  void getLatestAppVersion() async {
    _apiService.getLatestAppVersion().then((result) async {
      if (result == null) return;

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      bool isAndroid = Theme.of(context).platform == TargetPlatform.android;

      final resultVersionStr =
          isAndroid ? result.latestVersionAndroid : result.latestVersionIos;

      if (resultVersionStr != currentVersion) {
        final isForcedUpdate =
            isAndroid ? result.isForcedUpdateAndroid : result.isForcedUpdateIos;
        DialogUtils.instance
            .createUpdateDialog(context, isForcedUpdate, isAndroid);
      }
    });
  }

  void initializeNonCategorizedNews() async {
    _nonCategorizedArticlesController = ScrollController();
    _nonCategorizedArticlesController.addListener(() {
      if (_nonCategorizedArticlesController.isEndOfPage() &&
          !_isLoadingNonCategorizedArticles) {
        setState(() {
          _isLoadingNonCategorizedArticles = true;
          loadNonCategorizedArticles();
        });
      }
    });
    loadNonCategorizedArticles();
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
        .getArticles(
      categoryId: categorySelected,
      limit: CATEGORIZED_NEWS_PAGE_SIZE,
      page: currentPage,
    )
        .then((value) {
      setState(() {
        currentPage += 1;
        _isLoadingCategorizedNews = false;
        _categorizedArticles.addAll(value);
      });
    });
  }

  loadNonCategorizedArticles() async {
    _apiService
        .getArticles(
      limit: CATEGORIZED_NEWS_PAGE_SIZE,
      page: currentPageNonCategorized,
    )
        .then((articles) {
      setState(() {
        currentPageNonCategorized += 1;
        _isLoadingNonCategorizedArticles = false;
        _nonCategorizedArticles.addAll(articles);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _priorityNewsWidget(),
            SizedBox(
              height: 14.0,
            ),
            _topStoriesWidget(),
            SizedBox(
              height: 14.0,
            ),
            CategoryList(
              categories: _categories,
              setCategoryCallback: setCategory,
            ),
            SizedBox(
              height: 14.0,
            ),
            _categorizedNewsWidget(),
            SizedBox(
              height: 16.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _nonCategorizedNewsWidget(),
                SizedBox(
                  height: 16.0,
                ),
              ],
            )
          ],
        ),
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
    return CategorizedNewsSection(
      scrollController: _controller,
      articles: _categorizedArticles,
      categoryName: categoryName,
      isLoading: _isLoadingCategorizedNews,
    );
  }

  Widget _nonCategorizedNewsWidget() {
    return NonCategorizedNewsSection(
      scrollController: _nonCategorizedArticlesController,
      articles: _nonCategorizedArticles,
      isLoading: _isLoadingNonCategorizedArticles,
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
