import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mongol_ebook/widgets/app.dart';
import 'package:get/get.dart';
import 'Controller/KeyboardController.dart';

const periodicTask='Periodic Task';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<KeyboardController>(KeyboardController());
  await Firebase.initializeApp();
  runApp(MongolBookApp());
}


