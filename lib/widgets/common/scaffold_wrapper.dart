import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatelessWidget {
  final Widget child;

  ScaffoldWrapper(this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: child);
  }
}