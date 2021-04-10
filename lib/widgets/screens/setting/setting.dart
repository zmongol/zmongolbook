import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Helper/AppSetting.dart';
import 'package:mongol_ebook/widgets/common/color_picker.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {


  _onBottomBarItemPressed(int index) {
    if (index == 0) {
      //Todo: show font selection
      return;
    }

    if (index == 1 || index == 2) {
      Color currentColor;
      if (index == 1) {
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
                if (index == 1) {
                  AppSetting.instance.contentTextStyle = AppSetting.instance.contentTextStyle.copyWith(color: color);
                } else {
                  AppSetting.instance.contentBackgroundColor = color;
                }
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
          body: Container(
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
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.text_fields, color: Colors.black),
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
