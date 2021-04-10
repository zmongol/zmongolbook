
import 'package:flutter/material.dart';

class AppSetting {
  Color contentBackgroundColor = Colors.grey[50]!;
  TextStyle contentTextStyle = TextStyle(fontFamily: 'qimedtig', fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black);

  AppSetting._privateConstructor();

  static final AppSetting _appSetting = AppSetting._privateConstructor();
  static AppSetting get instance {return _appSetting;}



}