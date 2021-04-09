import 'package:flutter/material.dart';

class PageTitle extends StatefulWidget {
  @override
  _PageTitleState createState() => _PageTitleState();
}

class _PageTitleState extends State<PageTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Container(
            height: 32,
          ),
          RotatedBox(
            quarterTurns: 1,
            child: BackButton(
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
