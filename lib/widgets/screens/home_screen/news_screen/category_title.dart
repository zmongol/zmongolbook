import 'dart:convert';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  String categoryTitle;
  CategoryTitle(this.categoryTitle);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      //width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: RotatedBox(
        quarterTurns: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            categoryTitle,
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
