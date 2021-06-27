import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:mongol/mongol.dart';

class DialogUtils {
  static const androidAppID = "zmongol.zmongolbook"; // package name
  static const iosAppID = "1562552502";

  static const title = "New Update";
  //To signify the importance of this update
  static const contentForced =
      "Please update to the latest version \n for optimal app experience.";
  // Just a minor update
  static const contentNormal = "A new update is available.";

  static const btnTextForced = "Download now";
  static const btnTextNormal = "OK";

  DialogUtils._privateConstructor();
  static final _instance = DialogUtils._privateConstructor();
  static DialogUtils get instance {
    return _instance;
  }

  void createUpdateDialog(
      BuildContext context, bool isForcedUpdate, bool isAndroid) async {
    final content = isForcedUpdate ? contentForced : contentNormal;
    final buttonText = isForcedUpdate ? btnTextForced : btnTextNormal;

    showDialog(
      context: context,
      builder: (_) => new MongolAlertDialog(
        title: new MongolText(
          title,
          style: Theme.of(context).textTheme.headline2!,
        ),
        content: new MongolText(
          content,
          style: Theme.of(context).textTheme.bodyText1!,
        ),
        actions: <Widget>[
          TextButton(
            child: MongolText(
              buttonText,
              style: Theme.of(context).textTheme.bodyText1!,
            ),
            onPressed: () {
              Navigator.of(context).pop();

              // Redirect user to Google Play / Apple App store if forced update
              if (isForcedUpdate) {
                LaunchReview.launch(
                  androidAppId: "zmongol.zmongolbook",
                  iOSAppId: "1562552502",
                  writeReview: false,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
