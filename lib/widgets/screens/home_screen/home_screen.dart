import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongol_ebook/Helper/AppStyles.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/books_screen/books_screen.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/news_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

class HomeScreen extends StatefulWidget {
  static List currentData = <dynamic>[];
  static int itemsIndex = 0;
  String deepLink = '';
  static bool isSearching = false;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const labelNews = "News";
  static const labelBook = "Book";
  static const labelProfile = "Profile";

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
      String? initialLink = await getInitialLink();
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
          String? index = event?.pathSegments[1];
          print('Deep link listener: ' + event.toString());
          print('title: ' + index!);
          widget.deepLink = event.toString();
          Navigator.of(context)
              .pushNamed('/detail', arguments: {'index': index});
        });
      });
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  _bodyView() {
    switch (_selectedIndex) {
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
              _buildTitle(),
              style: Theme.of(context).textTheme.headline1,
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  HomeScreen.itemsIndex = _selectedIndex;
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
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: _bodyView(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 14.0),
            unselectedLabelStyle:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 14.0),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: labelNews),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: labelBook),
              BottomNavigationBarItem(
                  icon: Icon(Icons.perm_identity), label: labelProfile)
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.green[500],
            onTap: _onItemTapped,
          )),
    );
  }

  String _buildTitle() {
    var title = 'Z ᢌᡭᡪᢊᡱᡱᡭᢐ';
    var ending;
    switch (_selectedIndex) {
      case 0:
        ending = labelNews;
        break;
      case 1:
        ending = labelBook;
        break;
      case 2:
        ending = labelProfile;
        break;
      default:
        break;
    }

    if (ending == null) {
      return title;
    } else {
      return title + ' ' + ending;
    }
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
