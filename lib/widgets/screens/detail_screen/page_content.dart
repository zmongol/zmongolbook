import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Api%20Manager/api_manager.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';
import 'package:mongol_ebook/Helper/DataReader.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/widgets/app.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/home_screen.dart';

class PageContent extends StatefulWidget {
  final String index;

  PageContent(this.index);

  @override
  _PageContentState createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
    static late Future <Article> article;
       String id='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      setState(() {
        article = ApiManager.getData(widget.index);
      });

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Article>(
        future: article,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return loadingView();
              }
            case ConnectionState.done:
              {
                if(snapshot.data != null) {
                  return Container(
                      decoration:
                      BoxDecoration(color: Theme
                          .of(context)
                          .backgroundColor),
                      child: SafeArea(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppSetting.instance.contentBackgroundColor,
                          ),
                          width: double.infinity,
                          height: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(16),
                            child: MongolText(
                              snapshot.data!.content,
                              //DataReader.instance.getContentByIndex(widget.index),
                              style: AppSetting.instance.contentTextStyle,
                            ),
                          ),
                        ),
                      ));
                }
                break;
              }
          }
          return Container();
        });
  }

  Widget loadingView() => Center(
    child: LoadingIndicator(),
  );
}
