import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  FadePageRoute({required Widget child, required RouteSettings settings}) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        )
    {
      return child;
    },
    settings: settings,
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        )
    {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
