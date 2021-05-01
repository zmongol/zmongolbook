import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mongol_ebook/widgets/app.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import 'Controller/KeyboardController.dart';

const periodicTask='Periodic Task';

  void showNotification( v, flp) async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flp.show(0, 'Zmongol', '$v', platform,
        payload: 'VIS \n $v');
  }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<KeyboardController>(KeyboardController());
  // await Workmanager().initialize(callbackDispatcher, isInDebugMode: true); //to true if still in testing lev turn it to false whenever you are launching the app
  // await Workmanager().registerPeriodicTask("1", periodicTask,
  //     existingWorkPolicy: ExistingWorkPolicy.replace,
  //     frequency: Duration(minutes: 15),//when should it check the link
  //     initialDelay: Duration(seconds: 5),//duration before showing the notification
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //     ));
  runApp(MongolBookApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {

    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    flp.initialize(initSetttings);

    // var response= await http.post('https://seeviswork.000webhostapp.com/api/testapi.php');
    // print("here================");
    // print(response);
    // var convert = json.decode(response.body);
    //if (convert['status']  == true) {
      showNotification('test msg', flp);
    // } else {
    //   print("no messgae");
    // }
    return Future.value(true);
  });
}
