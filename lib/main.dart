import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongol_ebook/Helper/http_overrride.dart';
import 'package:mongol_ebook/widgets/app.dart';

import 'Controller/KeyboardController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpCertificate.call();
  Get.put<KeyboardController>(KeyboardController());
  runApp(MongolBookApp());
}
