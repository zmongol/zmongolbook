import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  int categoryTitle;
  CategoryTitle(this.categoryTitle);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
      ),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: RotatedBox(
        quarterTurns: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Category '+categoryTitle.toString(),
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}