import 'package:flutter/material.dart';
import 'package:mongol_ebook/widgets/app.dart';
import './page_content.dart';
import 'package:share/share.dart';

class DetailScreen extends StatefulWidget {
  final String index;


  DetailScreen(this.index);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

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
              actions: [
                GestureDetector(
                  onTap: () {
                    Share.share('http://Zmongol/detail/'+widget.index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
              ],
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
