import 'package:flutter/material.dart';
import 'package:mongol_ebook/Helper/DataReader.dart';
import 'package:mongol_ebook/widgets/app.dart';

class SingleItem extends StatelessWidget {
  final int index;
  String title;

  SingleItem(this.index, this.title);

  @override
  Widget build(BuildContext context) {
    String id = '';
    return GestureDetector(
      onTap: () {
        id = getIdFromTitle(id);
        Navigator.of(context).pushNamed('/detail', arguments: {'index': id});
      },
      child: Container(
        margin: EdgeInsets.all(4),
        width: 100,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(4)),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: RotatedBox(
            quarterTurns: 1,
            child: Row(
              children: [
                Image.network("https://picsum.photos/250?image=9"),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    title,
                    //DataReader.instance.getTitleByIndex(index),
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.left,
                    //maxLines: 1,
                   // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getIdFromTitle(String id) {
    for (var item in MongolBookApp.apiData) {
      //print('ID: ' + item['id']);
      if (item['garqag'].toString().toLowerCase().compareTo(title) == 0) {
        id = item['id'];
      }
    }
    return id;
  }
}
