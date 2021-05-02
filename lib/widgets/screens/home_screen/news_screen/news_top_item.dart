import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';

class NewsTopItem extends StatelessWidget {
  double deviceWidth;
  NewsTopItem(this.deviceWidth);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
        BoxDecoration(color: Theme.of(context).backgroundColor),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              color: AppSetting.instance.contentBackgroundColor,
            ),
            width: deviceWidth*0.33,
            height: 185,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              child: MongolText(
                "Top 3 mongol stories",
                //DataReader.instance.getContentByIndex(widget.index),
                style: AppSetting.instance.contentTextStyle,
              ),
            ),
          ),
        ));
  }
}
