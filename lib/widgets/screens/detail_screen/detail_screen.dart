import 'package:flutter/material.dart';
import './page_content.dart';
import './page_title.dart';

class DetailScreen extends StatefulWidget {
  final int index;

  DetailScreen(this.index);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Row(
        children: [
          PageTitle(),
          Expanded(child: PageContent(widget.index))
        ],
      ),
    );
  }
}
