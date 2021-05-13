import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/search_screen_news.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/search_screen.dart';
import 'package:mongol_ebook/widgets/screens/login_screen/login_screen.dart';
import 'package:mongol_ebook/widgets/screens/login_screen/signup_screen.dart';
import 'package:mongol_ebook/widgets/screens/search.dart';
import 'package:mongol_ebook/widgets/widget_index.dart';

import 'common/fade_page_route.dart';
import 'common/scaffold_wrapper.dart';

class MongolBookApp extends StatefulWidget {
  static List apiData = <dynamic>[];

  @override
  _MongolBookAppState createState() => _MongolBookAppState();
}

class _MongolBookAppState extends State<MongolBookApp>
    with WidgetsBindingObserver {
  GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'navigatorKey');
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'zmongolbook', // id
    'High Importance Notifications', // title
    'This channel is used for new articles notifications.', // description
    importance: Importance.max,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
    AppSetting.instance.get();
    showForegroundNotification();
  }

  Future showForegroundNotification() async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    flp.initialize(initSetttings);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Firebase: " + message.notification!.body.toString());
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        showNotification(message.notification!.body.toString(), flp);
      }
    });
  }

  void showNotification(v, flp) async {
    var android = AndroidNotificationDetails(
        'zmongolbook', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var platform = NotificationDetails(android: android);
    await flp.show(0, 'Zmongolbook', '$v', platform, payload: 'VIS \n $v');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _theme() {
    return ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
              fontFamily: 'z52ordostig',
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Colors.black),
          headline2: TextStyle(
              fontFamily: 'haratig',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black),
          headline3: TextStyle(
              fontFamily: 'haratig',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey),
          subtitle1: TextStyle(
              fontFamily: 'haratig',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black),
          subtitle2: TextStyle(
              fontFamily: 'haratig', fontSize: 10, fontWeight: FontWeight.w400),
          bodyText1: TextStyle(
              fontFamily: 'z52qimedtig',
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.black),
          button: TextStyle(
              fontFamily: 'haratig',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        primaryColor: Colors.grey[200],
        backgroundColor: Colors.grey[50]);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 640),
        allowFontScaling: false,
        builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _theme(),
            navigatorKey: navigatorKey,
            title: 'Mongol Book App',
            initialRoute: '/',
            routes: {
              '/': (BuildContext context) {
                return LoginPage();
              },
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/home')
                return FadePageRoute(
                    child: ScaffoldWrapper(HomeScreen()), settings: settings);
              if (settings.name == '/detail') {
                Map args = settings.arguments as Map;
                if (args['index'] != null) {
                  return FadePageRoute(
                      child: ScaffoldWrapper(DetailScreen(args['index'])),
                      settings: settings);
                } else {
                  return null;
                }
              }
              if (settings.name == '/signup')
                return FadePageRoute(
                    child: ScaffoldWrapper(SignupPage()), settings: settings);
              if (settings.name == '/login')
                return FadePageRoute(
                    child: ScaffoldWrapper(LoginPage()), settings: settings);
              if (settings.name == '/search')
                return FadePageRoute(
                    child: ScaffoldWrapper(SearchScreen()), settings: settings);
              if (settings.name == '/searchResult') {
                Map args = settings.arguments as Map;
                return FadePageRoute(
                    child: ScaffoldWrapper(SearchResultScreen(args['value'])),
                    settings: settings);
              }
              if (settings.name == '/categoriesSearchResult') {
                Map args = settings.arguments as Map;
                return FadePageRoute(
                    child: ScaffoldWrapper(
                        CategoriesSearchResultScreen(args['category'])),
                    settings: settings);
              }
              if (settings.name == '/setting')
                return FadePageRoute(
                    child: ScaffoldWrapper(SettingScreen()),
                    settings: settings);

              return null;
            }));
  }
}
