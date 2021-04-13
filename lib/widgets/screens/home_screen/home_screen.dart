import 'package:flutter/material.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Helper/DataReader.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'horizontal_items.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _isLoading = false;
  bool _isSearching = false;

  @override
  initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    setState(() {
      _isLoading = true;
    });
    await DataReader.instance.readData();
    setState(() {
      _isLoading = false;
    });
  }

  _resetData() {
    setState(() {
      _isSearching = false;
      DataReader.instance.data = DataReader.instance.originalData;
    });
  }

  _search(dynamic value) {
    if (value is String) {
      if (value.isEmpty) {
        _resetData();
      } else {
        final searchData = DataReader.instance.originalData.where((element) => element['title']!.toLowerCase().contains(value.toLowerCase())).toList();
        DataReader.instance.data = searchData;
        _isSearching = true;
        setState(() {
        });
      }
    }
  }

  _bodyView() {
    int numberOfRow = DataReader.instance.data.length ~/ ITEMS_IN_ROW;
    if (DataReader.instance.data.length % ITEMS_IN_ROW > 0) {
      numberOfRow ++;
    }
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return HorizontalItems(index);
            },
            itemCount: numberOfRow)
        ),
        _isLoading ? LoadingIndicator() : Container()
      ],
    );
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
                  if (_isSearching) {
                    _resetData();
                    return;
                  }
                  Navigator.of(context).pushNamed('/search').then((value) {
                    _search(value);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon (
                    _isSearching ? Icons.search_off : Icons.search,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/setting');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon (
                    Icons.settings,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
          body: _bodyView()
        ),
      ),
    );
  }
}