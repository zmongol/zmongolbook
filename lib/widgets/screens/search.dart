import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongol_ebook/Controller/KeyboardController.dart';
import 'package:mongol_ebook/widgets/Keyboard/MongolKeyboard.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: GestureDetector(
              onTap: () {Navigator.pop(context);},
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GetBuilder<KeyboardController>(
                  builder: (keyboardCtrl) {
                    return Container(
                      height: 250,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Center(
                          child: Text(
                            keyboardCtrl.text,
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                MongolKeyboard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
