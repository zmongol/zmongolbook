

import 'package:flutter/material.dart';
import 'package:mongol_ebook/Api%20Manager/api_manager.dart';
import 'package:mongol_ebook/widgets/app.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';

import 'horizontal_items.dart';

class BooksScreen extends StatefulWidget {
  static List currentData = <dynamic>[];
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return HorizontalItems(index);
                },
                itemCount: (BooksScreen.currentData.length / 4).toInt())),
        _isLoading
            ? LoadingIndicator()
            : Container(
          child: BooksScreen.currentData.length == 0
              ? Text('No Data Found')
              : null,
        )
      ],
    );
  }

  loadData() async {
    ApiManager.getTitle().then((value) {
      setState(() {
        MongolBookApp.apiData = value;
        BooksScreen.currentData = List.from(MongolBookApp.apiData);
        _isLoading = false;
      });
    });
  }

}
