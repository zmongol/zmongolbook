import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';

class NewsTopItem extends StatelessWidget {
  double deviceWidth;
  String title;
  NewsTopItem(this.deviceWidth,this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: deviceWidth*0.33,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
      ),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MongolText(
          title,
          style: Theme.of(context).textTheme.headline2,
          softWrap: true,
        ),
      ),
    );
  }
}

// return Container(
// decoration:
// BoxDecoration(color: Theme.of(context).backgroundColor),
// child: SafeArea(
// child: Container(
// padding: EdgeInsets.all(0),
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black54),
// color: AppSetting.instance.contentBackgroundColor,
// ),
// width: deviceWidth*0.33,
// height: 185,
// child: SingleChildScrollView(
// scrollDirection: Axis.horizontal,
// padding: const EdgeInsets.all(16),
// child: MongolText(
// title,
// style: AppSetting.instance.contentTextStyle,
// ),
// ),
// ),
// ));