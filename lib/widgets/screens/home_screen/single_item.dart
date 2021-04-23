import 'package:flutter/material.dart';
import 'package:mongol_ebook/Helper/DataReader.dart';

class SingleItem extends StatelessWidget {
  final int index;
  String title;
  SingleItem(this.index,this.title);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: {'title': title});
      },
      child: Container(
        margin: EdgeInsets.all(4),
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(4)),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: RotatedBox(
            quarterTurns: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                //DataReader.instance.getTitleByIndex(index),
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
