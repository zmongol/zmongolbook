
import 'package:flutter/material.dart';
import 'package:mongol_ebook/Helper/AppConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSetting {
  Color contentBackgroundColor = Colors.grey[200]!;
  TextStyle contentTextStyle = TextStyle(fontFamily: 'z52ordostig', fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black);

  AppSetting._privateConstructor();
  static final AppSetting _appSetting = AppSetting._privateConstructor();
  static AppSetting get instance {return _appSetting;}


  save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CONTENT_FONT_FAMILY, contentTextStyle.fontFamily!);
    await prefs.setString(CONTENT_TEXT_COLOR, contentTextStyle.color!.value.toRadixString(16));
    await prefs.setString(CONTENT_BACKGROUND_COLOR, contentBackgroundColor.value.toRadixString(16));
    await prefs.setDouble(CONTENT_FONT_SIZE, contentTextStyle.fontSize!);
  }

  get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fontFamily = prefs.getString(CONTENT_FONT_FAMILY) ?? 'z52tsagaantig';
    double fontSize = prefs.getDouble(CONTENT_FONT_SIZE) ?? 22;
    String textColorHex = prefs.getString(CONTENT_TEXT_COLOR) ?? 'ff000000';
    Color textColor = Color(int.parse('0x$textColorHex'));
    String bgColorHex = prefs.getString(CONTENT_BACKGROUND_COLOR) ?? 'FFFAFAFA'; // Colors.grey[50]
    Color bgColor = Color(int.parse('0x$bgColorHex'));
    contentTextStyle = contentTextStyle.copyWith(fontFamily: fontFamily, fontSize: fontSize, color: textColor);
    contentBackgroundColor = bgColor;
  }
}