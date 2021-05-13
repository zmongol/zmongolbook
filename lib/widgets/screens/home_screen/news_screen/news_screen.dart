import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Api%20Manager/api_manager.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';
import 'package:mongol_ebook/Model/category_article.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/category_item.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/home_screen.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/news_top_item.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/books_screen/single_item.dart';

import 'category_title.dart';

class NewsScreen extends StatefulWidget {
  static List categoryTitles = <dynamic>[];
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String categorySelected = 'Category';
  String categoryName = '';


  static List categoryArticles = <CategoryArticle>[];
  static List topArticles = <dynamic>[];
  int offset = 0;
  late ScrollController _controller;
  bool _isLoading = true;
  bool _isLoading2 = true;

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
        _isLoading2 = false;
        topArticles = List.from(value);
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
        NewsScreen.categoryTitles = value;
        categorySelected = NewsScreen.categoryTitles[0]['category'];
        categoryName = NewsScreen.categoryTitles[0]["category_name"];
        loadArticles();
      });
    });
  }

  loadArticles() async {
    ApiManager.getCategoryArticles(categorySelected, offset.toString())
        .then((value) {
      setState(() {
        offset = offset + 50;
        _isLoading = false;
        // categoryArticles.addAll(value.map((e) {
        //   return e;
        // }));
        // categoryArticles=value;
        categoryArticles.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                "http://east-mod.oss-cn-beijing.aliyuncs.com/Zcode%20123.JPG@!content-image",
                width: deviceWidth * 0.75,
                height: 200,
              ),
              Expanded(
                child: Container(
                  height: 200,
                  width: deviceWidth * 0.35,
                  margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _isLoading2
                        ? LoadingIndicator()
                        : InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/detail',
                                  arguments: {'index': topArticles[0]['id']});
                            },
                            child: MongolText(
                              topArticles.isNotEmpty
                                  ? topArticles[0]['tittle']
                                  : 'Top Article',
                              style: Theme.of(context).textTheme.headline2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return _isLoading2
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: LoadingIndicator(),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('/detail',
                                    arguments: {
                                      'index': topArticles[index + 1]['id']
                                    });
                              },
                              child: NewsTopItem(
                                  deviceWidth,
                                  topArticles.isNotEmpty
                                      ? topArticles[index + 1]['tittle'] +
                                          topArticles[index + 1]['content']
                                      : "Top Articles"));
                    },
                    itemCount: 3,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categoryName,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              _isLoading
                  ? LoadingIndicator()
                  : Container(
                      constraints: new BoxConstraints(
                        maxWidth: deviceWidth * 0.8,
                        minHeight: 35.0,
                        maxHeight: 300.0,
                      ),
                      child: ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryArticles.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('/detail',
                                    arguments: {
                                      'index': categoryArticles[index].id
                                    });
                              },
                              child:
                                  CategoryItem(categoryArticles[index].title));
                        },
                      ),
                    ),
            ],
          ),
          Container(
            constraints: new BoxConstraints(
              minHeight: 35.0,
              maxHeight: 180.0,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: NewsScreen.categoryTitles.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      setCategory(NewsScreen.categoryTitles[index]['category'],
                          NewsScreen.categoryTitles[index]['category_name']);
                    },
                    child:
                        CategoryTitle(NewsScreen.categoryTitles[index]['category_name']));
              },
            ),
          ),
        ],
      ),
    );
  }

  setCategory(String cat, String name) {
    setState(() {
      categorySelected = cat;
      categoryName = name;
      offset = 0;
      categoryArticles.clear();
      _isLoading = true;
      loadArticles();
    });
  }
}
