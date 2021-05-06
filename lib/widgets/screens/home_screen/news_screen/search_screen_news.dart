
import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Api%20Manager/api_manager.dart';
import 'package:mongol_ebook/Model/category_article.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/books_screen/single_item.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/news_screen.dart';

class CategoriesSearchResultScreen extends StatefulWidget {
  String category;

  CategoriesSearchResultScreen(this.category);
  @override
  _CategoriesSearchResultScreenState createState() => _CategoriesSearchResultScreenState();
}

class _CategoriesSearchResultScreenState extends State<CategoriesSearchResultScreen> {
  List currentData = <CategoryArticle>[];
  String categoryId='';
  bool _isLoading = true;
  int offset=0;
  late ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    loadArticles();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
     _search(widget.category);

    }
  }

  loadArticles() async {
    ApiManager.getCategoryArticles(categoryId, offset.toString())
        .then((value) {
      setState(() {
        if(value.length>0) {
          offset = offset + 50;
          _isLoading = false;
          currentData.addAll(value);
        }
        else{
          _isLoading = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        child: SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 40,
              centerTitle: true,
              title: Text(
                'ZmongolBook',
                style: Theme.of(context).textTheme.headline1,
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, '');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.search_off,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
            body: _bodyView(),
          ),
        )
    );
  }
  _bodyView()
  {
    return Stack(
      children: [
        Container(
          // width: double.infinity,
          //  height: double.infinity,
            constraints: BoxConstraints(maxHeight: 500),
            padding: EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              controller: _controller,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: ()
                    {
                      Navigator.of(context).pushNamed('/detail',
                          arguments: {
                            'index': currentData[index].id
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Row(
                            children: [
                              Image.network("https://picsum.photos/250?image=9"),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  currentData[index].title,
                                  style: Theme.of(context).textTheme.headline2,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: (currentData.length))),
        _isLoading
            ? LoadingIndicator()
            : Container(
          child: currentData.length == 0
              ? Text('No Such Category Found')
              : null,
        )
      ],
    );
  }

  _search(dynamic value) {
    if (value is String) {
      if (value.isEmpty) {
        setState(() {
          _isLoading = false;
        });
      } else {
        for (var item in NewsScreen.categoryTitles) {
          if (item['category_name'] == value.toLowerCase()) {
            print("Title: " + item['category_name'].toString().toLowerCase());
            categoryId=item['category'];
            loadArticles();
            break;
          }
        }
      }
    }
  }

}
