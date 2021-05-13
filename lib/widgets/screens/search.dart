import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Controller/KeyboardController.dart';
import 'package:mongol_ebook/widgets/Keyboard/MongolKeyboard.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/home_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode _focusNode = FocusNode();
  List teinIlgalCands = [
    'ᡭᡧ',
    'ᡬᡬᡧ',
    'ᡳ',
    "ᡭᡳ",
    "ᡳᡪᢝ",
    "ᡬᡬᡪᢝ",
    "ᡳᡪᡧ",
    "ᡬᡬᡪᡧ",
    'ᢘᡳ',
    'ᢙᡳ',
    'ᡬᡫ',
    'ᡫ',
    'ᡥᢚᡧ',
    "ᢘᡪᡫ",
    "ᡭᡭᡧ",
    "ᢘᡪᡱᡱᡪᡧ",
    "ᢘᡪᢊᡪᡧ",
    "ᢙᡪᡱᡱᡪᡧ",
    "ᢙᡪᢊᡪᡧ",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: SafeArea(child: GetBuilder<KeyboardController>(
        builder: (kbCtrl) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Search by Title"),
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context, '');
                  kbCtrl.textEditingController.text = '';
                },
                child: Icon(Icons.arrow_back),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    _goToSearchResults(kbCtrl.textEditingController.text);
                    kbCtrl.textEditingController.text = '';
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.done)),
                ),
              ],
            ),
            body: Container(
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      height: 250,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: MongolTextField(
                        scrollPadding: const EdgeInsets.only(),
                        autofocus: true,
                        readOnly: true,
                        focusNode: _focusNode,
                        expands: true,
                        maxLines: null,
                        textAlign: MongolTextAlign.top,
                        controller: kbCtrl.textEditingController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(),
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.newline,
                      )),
                  GetBuilder<KeyboardController>(
                      id: 'cands',
                      builder: (ctr) {
                        print('teinIlgalCands :${teinIlgalCands.length}');
                        print('latin.value.length :${ctr.latin.value.length}');
                        return Material(
                          color: Colors.grey.shade100,
                          elevation: 3,
                          child: Obx(
                            () {
                              late double candsHeight;
                              if (ctr.latin.value.length >= 7) {
                                var len = ctr.latin.value.length;
                                candsHeight =
                                    len * ScreenUtil().setHeight(6.0) + 75;
                                print('candsHeight $candsHeight');
                              } else if (ctr.latin.value.length < 7) {
                                candsHeight = ScreenUtil().setHeight(90.0);
                              }
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: candsHeight,
                                child: ctr.latin.value.isEmpty
                                    ? Stack(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      teinIlgalCands.length,
                                                  itemBuilder:
                                                      (context, int i) {
                                                    var e = teinIlgalCands[i];
                                                    return InkWell(
                                                      onTap: () {
                                                        ctr.enterAction(e);
                                                      },
                                                      child: Container(
                                                        height: 100,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: MongolText(
                                                            e,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'haratig',
                                                                fontSize: 24),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  })),
                                        ],
                                      )
                                    : Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: candsHeight,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: ctr.cands.length,
                                                    itemBuilder:
                                                        (context, int i) {
                                                      var e = ctr.cands[i];
                                                      return InkWell(
                                                        onTap: () {
                                                          ctr.enterAction(e);
                                                        },
                                                        child: Container(
                                                          height: candsHeight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            child: MongolText(
                                                              e,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'haratig',
                                                                  fontSize: 24),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    })),
                                          ),
                                          Positioned(
                                              bottom: 0,
                                              left: 150,
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  ctr.latin.value,
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      color: Colors.black),
                                                ),
                                              )),
                                        ],
                                      ),
                              );
                            },
                          ),
                        );
                      }),
                  MongolKeyboard()
                ],
              ),
            ),
          );
        },
      )),
    );
  }

  void _goToSearchResults(String query) {
    Navigator.of(context)
        .pushReplacementNamed('/searchResult', arguments: {'value': query});
  }
}
