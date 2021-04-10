import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';
import 'package:mongol_ebook/Utils/DataDemo.dart';

class PageContent extends StatefulWidget {
  final int index;
  PageContent(this.index);
  
  @override
  _PageContentState createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppSetting.instance.contentBackgroundColor,
          ),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(16),
            child: MongolText(
              DataDemo.instance.getContentByIndex(widget.index),
              style: AppSetting.instance.contentTextStyle,
          ),
        ),
      ),
    ));
  }
}
