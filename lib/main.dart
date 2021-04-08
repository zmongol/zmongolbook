import 'package:flutter/material.dart';
import 'package:mongol_ebook/widgets/app.dart';
import './widgets/screens/home_screen/home_screen.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:get/get.dart';
import 'Controller/KeyboardController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<KeyboardController>(KeyboardController());
  runApp(MongolBookApp());
}
