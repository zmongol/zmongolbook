import 'package:flutter/material.dart';
import 'package:mongol_ebook/widgets/screens/search.dart';
import 'package:mongol_ebook/widgets/widget_index.dart';

import 'common/fade_page_route.dart';
import 'common/scaffold_wrapper.dart';

class MongolBookApp extends StatefulWidget {

  @override
  _MongolBookAppState createState() => _MongolBookAppState();

}

class _MongolBookAppState extends State<MongolBookApp> with WidgetsBindingObserver {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'navigatorKey');

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  _theme() {
    return ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(fontFamily: 'haratig', fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
          headline2: TextStyle(fontFamily: 'haratig', fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
          headline3: TextStyle(fontFamily: 'haratig', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
          subtitle1: TextStyle(fontFamily: 'haratig', fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
          subtitle2: TextStyle(fontFamily: 'haratig', fontSize: 10, fontWeight: FontWeight.w400),
          bodyText1: TextStyle(fontFamily: 'haratig', fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
          button: TextStyle(fontFamily: 'haratig', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        primaryColor: Colors.grey[200],
        backgroundColor: Color(0xfffafafa)
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _theme(),
        navigatorKey: navigatorKey,
        title: 'Mongol Book App',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) {
           return HomeScreen();
          },
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/home')
            return FadePageRoute(child: ScaffoldWrapper(HomeScreen()), settings: settings);
          if (settings.name == '/detail')
            return FadePageRoute(child: ScaffoldWrapper(DetailScreen()), settings: settings);
          if (settings.name == '/search')
            return FadePageRoute(child: ScaffoldWrapper(SearchScreen()), settings: settings);
          return null;
        }
    );
  }
}