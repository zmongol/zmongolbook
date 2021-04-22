import 'package:flutter/material.dart';
import './page_content.dart';

class DetailScreen extends StatefulWidget {
  final int index;


  DetailScreen(this.index);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 40,
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {Navigator.pop(context);},
                child: Icon(Icons.arrow_back,color: Colors.black,),
              ),
            ),
            body: PageContent(widget.index)
        ),
      ),
    );
  }
}
