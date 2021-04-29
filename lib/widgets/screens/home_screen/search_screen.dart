import 'package:flutter/material.dart';
import 'package:mongol_ebook/widgets/app.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/single_item.dart';

class SearchResultScreen extends StatefulWidget {
  final dynamic value;
  SearchResultScreen(this.value);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchResultScreen> {

  List currentData = <dynamic>[];
   bool _isLoading = true;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _search(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 40,
              centerTitle: true,
              title: Text(
                'ZmongolBook',
                style: Theme.of(context).textTheme.headline1,
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, '');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.search_off,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
            body: _bodyView(),
      ),
    ));
  }

  _bodyView()
  {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(16),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SingleItem(index, currentData[index]['garqag']);
                },
                itemCount: (currentData.length))),
        _isLoading
            ? LoadingIndicator()
            : Container(
          child: currentData.length == 0
              ? Text('No Data Found')
              : null,
        )
      ],
    );
  }

   _search(dynamic value) {
     if (value is String) {
       if (value.isEmpty) {
        currentData.length=0;
       } else {
         for (var item in MongolBookApp.apiData) {
           if (item['garqag']
               .toString()
               .toLowerCase()
               .contains(value.toLowerCase())) {
             print("Title: "+item['garqag'].toString().toLowerCase());
             currentData.add(item);
           }
         }
         setState(() {
           _isLoading=false;
         });
       }
     }
   }
}
