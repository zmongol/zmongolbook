import 'package:flutter/material.dart';
import 'package:mongol_ebook/widgets/app.dart';
import 'package:get/get.dart';
import 'Controller/KeyboardController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<KeyboardController>(KeyboardController());
  runApp(MongolBookApp());
}
