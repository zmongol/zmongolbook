import 'dart:async';
import 'dart:collection';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mongol_ebook/Api%20Manager/api_manager.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Helper/DataReader.dart';
import 'package:mongol_ebook/widgets/app.dart';
import 'package:mongol_ebook/widgets/common/loading_indicator.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/books_screen/books_screen.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/news_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'books_screen/horizontal_items.dart';

class HomeScreen extends StatefulWidget {
  static List currentData = <dynamic>[];
  static int itemsIndex = 0;
  String deepLink = '';
  static bool isSearching = false;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  late StreamSubscription _sub;
  int _selectedIndex = 0;

  @override
  initState() {
    super.initState();
    initUniLinks();
  }

  Future<Null> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      String initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      if (initialLink != null) {
        if (initialLink.contains('Zmongol')) {
          Uri uri = Uri.parse(initialLink);
          setState(() {
            print('Initial Deep link : ' + uri.toString());
            print('title: ' + uri.pathSegments[1].toString());
            widget.deepLink = uri.toString();
            Navigator.of(context).pushNamed('/detail',
                arguments: {'index': uri.pathSegments[1].toString()});
          });
        }
      }
      _sub = getUriLinksStream().listen((event) {
        setState(() {
          print('Deep link listener: ' + event.toString());
          print('title: ' + event.pathSegments[1].toString());
          widget.deepLink = event.toString();
          Navigator.of(context).pushNamed('/detail',
              arguments: {'index': event.pathSegments[1].toString()});
        });
      });
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  _resetData() {
    setState(() {
      HomeScreen.isSearching = false;
      print("Api Data: " + MongolBookApp.apiData.length.toString());
      HomeScreen.currentData = List.from(MongolBookApp.apiData);
    });
  }


  _bodyView() {
    // int numberOfRow = DataReader.instance.data.length ~/ ITEMS_IN_ROW;
    // if (DataReader.instance.data.length % ITEMS_IN_ROW > 0) {
    //   numberOfRow++;
    // }

    switch(_selectedIndex)
    {
      case 0:
        {
          return NewsScreen();
        }
      case 1:
        {
          return BooksScreen();
        }
      default:
        {
          return Container();
        }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
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
                  // if (HomeScreen.isSearching) {
                  //   _resetData();
                  //   return;
                  // }
                  HomeScreen.itemsIndex=_selectedIndex;
                   Navigator.of(context).pushNamed('/search');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: _selectedIndex == 2
                      ? null
                      : Icon(
                          Icons.search,
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
                  child: _selectedIndex == 2
                      ? Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 32,
                        )
                      : null,
                ),
              ),
            ],
            leading: GestureDetector(
              onTap: () {
                clearData();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: _selectedIndex == 2
                    ? Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 32,
                      )
                    : null,
              ),
            ),
          ),
          body: _bodyView(),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'News'),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Books'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.perm_identity), label: 'Profile')
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.green[500],
            onTap: _onItemTapped,
          )),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  clearData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
