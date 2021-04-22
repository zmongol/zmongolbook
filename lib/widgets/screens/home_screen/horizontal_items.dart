
import 'package:flutter/material.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Helper/DataReader.dart';
import './single_item.dart';

class HorizontalItems extends StatelessWidget {
  final int rowIndex;
  String title;

  HorizontalItems(this.rowIndex,this.title);

  @override
  Widget build(BuildContext context) {
    // int numberOfRow = DataReader.instance.data.length ~/ ITEMS_IN_ROW;
    // int a = DataReader.instance.data.length % ITEMS_IN_ROW;
    // if (a > 0) {
    //   numberOfRow++;
    // }
     int itemsInRow = ITEMS_IN_ROW;
    // if (rowIndex == numberOfRow - 1) {
    //   if (DataReader.instance.data.length % ITEMS_IN_ROW !=0 )
    //     itemsInRow = DataReader.instance.data.length % ITEMS_IN_ROW;
    // }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Container(
        constraints: new BoxConstraints(
          minHeight: 35.0,
          maxHeight: 300.0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (context, colIndex) {
            return SingleItem(rowIndex,title);
            //rowIndex * ITEMS_IN_ROW + colIndex
          },
        ),
      ),
    );
  }
}
