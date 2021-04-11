import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';
import 'package:mongol_ebook/Utils/MongolFont.dart';
import 'package:mongol_ebook/widgets/common/color_picker.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  PersistentBottomSheetController? _controller;

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  _showFontSelection() {
    _controller = showBottomSheet(context: context, builder: (BuildContext context) {
      return Container(
        color: Colors.white,
        height: 260,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemExtent: 48,
            itemCount: MongolFonts.fontList.length,
            itemBuilder: (context, int i) {
              return Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: InkWell(
                      onTap: () {
                        AppSetting.instance.contentTextStyle = AppSetting.instance.contentTextStyle.copyWith(fontFamily: MongolFonts.fontList[i][0]);
                        AppSetting.instance.save();
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: MongolText(
                        MongolFonts.fontList[i][1],
                        style: TextStyle(
                            fontSize: 28, fontFamily: MongolFonts.fontList[i][0]),
                      ),
                    ),
                  ));
            }),
      );
    });
  }

  _showFontSizeSlider() {
    _controller = showBottomSheet(context: context, builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, reloadSlider) {
        return Container(
              height: 100,
              margin: EdgeInsets.only(right: 10),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                  boxShadow: [new BoxShadow(color: Colors.black38, offset: new Offset(0.0, 2.0), blurRadius: 10)]),
              child: new Slider(
                value: AppSetting.instance.contentTextStyle.fontSize!,
                activeColor: Colors.grey,
                inactiveColor: Colors.grey,
                onChanged: (double newValue) {
                  AppSetting.instance.contentTextStyle = AppSetting.instance.contentTextStyle.copyWith(fontSize: newValue);
                  AppSetting.instance.save();
                  reloadSlider(() {});
                  setState(() {});
                },
                min: MIN_FONT_SIZE,
                max: MAX_FONT_SIZE,
              ),
            );
      });
    });
  }

  _onBottomBarItemPressed(int index) {
    if (index == 0) {
      _showFontSelection();
      return;
    } else if (index == 1) {
      _showFontSizeSlider();
    } else {
      Color currentColor;
      if (index == 2) {
        currentColor = AppSetting.instance.contentBackgroundColor;
      } else {
        currentColor = AppSetting.instance.contentTextStyle.color!;
      }

      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: currentColor ,
              onColorChanged: (Color color) {
                if (index == 2) {
                  AppSetting.instance.contentTextStyle = AppSetting.instance.contentTextStyle.copyWith(color: color);
                } else {
                  AppSetting.instance.contentBackgroundColor = color;
                }
                AppSetting.instance.save();
                Navigator.pop(context);
                setState(() {});
              },
              enableLabel: true,
            ),
          ),
        );
      });
    }
  }

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
          body: GestureDetector(
            onTap: () {
              if (_controller != null) {
                _controller!.close();
              }
            },
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppSetting.instance.contentBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              width: double.infinity,
              height: double.infinity,
              child: MongolText(
                'ᡥᡪᢞᡪᡭᡧ ᡭᡧ ᢘᡭᢎᢙᡪᢊᡬᡦ ᢌᡭᡪᢊᡱᡱᡭᢐ ᡳᡬᢚᡬᡬᡨ ᢌᡭᡪᢊᡱᡱᡭᢐ ᢜᡭᡬᡱᡬᢥᡭᢙᡦ ᢌᡪᢞᢊᡪᢛᡬᢐ ᡭᡧ ᢔᡪᡪᡬᡨ ᡭᡧ ᡥᡬᡳᡪᢊᡪᡧ ᢘᡪᡭᡪᢋᡭᢊᢚᡫ ᡯᡪᢝ ᡭᡧ ᡯᡪᢝᡨ ᡬᡬᡧ ᡬᡬᡪᡪᢔᡪᡱᡱᡪᢑᢙᡧ',
                style: AppSetting.instance.contentTextStyle,
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.text_fields, color: Colors.black),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.text_rotation_none_sharp, color: Colors.black),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.color_lens_outlined, color: Colors.black),
                  label: ''
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_color_fill, color: Colors.black),
                label: '',
              ),
            ],
            onTap: _onBottomBarItemPressed,
          ) ,
        ),
      ),
    );
  }
}
