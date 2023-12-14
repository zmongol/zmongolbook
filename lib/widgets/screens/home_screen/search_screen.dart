import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/network/api_service.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/common/rounded_image.dart';
import 'package:mongol_ebook/extensions/scroll_controller_extension.dart';

class SearchResultScreen extends StatefulWidget {
  final dynamic value;
  final String suffix;

  SearchResultScreen(this.value, this.suffix);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchResultScreen> {
  bool _isLoading = true;
  int _currentPage = 0;
  List<NewArticle> _articles = [];

  late ApiService _apiService;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.isEndOfPage() && !_isLoading) {
        setState(() {
          _isLoading = true;
          _search(widget.value);
        });
      }
    });
    _apiService = ApiService(Dio(), BASE_URL);
    _search(widget.value);
  }

  void _search(String query) {
    _apiService
        .getArticles(page: _currentPage, limit: 25, title: query)
        .then((articles) {
      setState(() {
        _articles.addAll(articles);
        _isLoading = false;
        _currentPage++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 40,
            centerTitle: true,
            title: Text(
              'Z ᢌᡭᡪᢊᡱᡱᡭᢐ ' + widget.suffix,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, '');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.search_off,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
          body: !_isLoading && _articles.isEmpty
              ? Center(
                  child: Text("No data found"),
                )
              : ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _resultsList(),
                    _isLoading
                        ? Container(
                            child: LoadingIndicator(),
                          )
                        : Container(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _resultsList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var article = _articles[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/detail',
              arguments: {'index': article.id},
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                RoundedImage(
                    size: 120.0,
                    imageUrl: article.imageUrl ?? _getImageUrl(article)),
                SizedBox(
                  height: 16.0,
                ),
                Flexible(
                  child: MongolText(
                    article.title,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.displayMedium!,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: _articles.length,
    );
  }

  String _getImageUrl(NewArticle article) {
    const placeholder1 =
        "https://pbs.twimg.com/profile_images/883859744498176000/pjEHfbdn_400x400.jpg";
    const placeholder2 =
        "https://discovery.sndimg.com/content/dam/images/discovery/fullset/2020/1/8/honeybees_articleimage.jpg.rend.hgtvcom.616.347.suffix/1578499708500.jpeg";
    const placeholder3 =
        "https://shopee.co.id/inspirasi-shopee/wp-content/uploads/2019/01/coveteur_marie_kondo_238_preview_maxwidth_2000_maxheight_2000_ppi_300_embedmetadata_true.jpg";
    const placeholder4 =
        "https://st2.depositphotos.com/2256213/12010/i/950/depositphotos_120104944-stock-photo-colloseum-rome-italy.jpg";

    String imgUrl = "";

    switch (article.id % 4) {
      case 1:
        imgUrl = placeholder1;
        break;
      case 2:
        imgUrl = placeholder2;
        break;
      case 3:
        imgUrl = placeholder3;
        break;
      default:
        imgUrl = placeholder4;
    }

    return imgUrl;
  }
}
