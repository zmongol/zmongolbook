import 'package:flutter/material.dart';
import 'package:mongol_ebook/Utils/DataDemo.dart';
import 'package:mongol_ebook/widgets/screens/detail_screen/detail_screen.dart';

class SingleItem extends StatelessWidget {
  final int index;

  SingleItem(this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: {'index': index});
      },
      child: Container(
        margin: EdgeInsets.all(4),
        width: 52,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(4)),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: RotatedBox(
            quarterTurns: 1,
            child: Center(
              child: Text(
                DataDemo.instance.getTitleByIndex(index),
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
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
