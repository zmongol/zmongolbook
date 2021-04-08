import 'package:flutter/material.dart';
import './page_content.dart';
import './page_title.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Row(
        children: [
          PageTitle(),
          Expanded(child: PageContent())
        ],
      ),
    );
  }
}
