import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/category_item.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/home_screen.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_top_item.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/single_item.dart';

import 'category_title.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Image.network("https://picsum.photos/250?image=9"),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Mongol Title',
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              NewsTopItem(deviceWidth),
              NewsTopItem(deviceWidth),
              NewsTopItem(deviceWidth)
            ],
          ),
          Row(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                ),
                margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Category Title',
                      //DataReader.instance.getTitleByIndex(index),
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Container(
                constraints: new BoxConstraints(
                  maxWidth: deviceWidth*0.8,
                  minHeight: 35.0,
                  maxHeight: 300.0,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 14,
                  itemBuilder: (context, index) {
                    return CategoryItem(index);
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
              itemCount: 14,
              itemBuilder: (context, index) {
                return CategoryTitle(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
