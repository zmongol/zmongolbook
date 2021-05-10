import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';

class CategoryItem extends StatelessWidget {
  String article;
  CategoryItem(this.article);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 70,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).cardColor),
      ),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MongolText(
          article,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
