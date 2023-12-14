import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:mongol/mongol.dart';

class DialogUtils {
  static const androidAppID = "zmongol.zmongolbook"; // package name
  static const iosAppID = "1562552502";

  static const title = "ᢔᡬᡰᡨ ᢊᡪᡲ ᡫ ᢘᡪᢙᡪᡱᡱᡪᢞᡪᡫ";
  //To signify the importance of this update
  static const contentForced =
      "ᢔᡬᡰᡨ ᢊᡪᡲ ᡫ ᡬᡪᡳᡪᢐ ᢘᡪᢙᡪᡳᡪᢐ \nᢔᡪᢜᡫ ᡥᡭᡬᢞᢋᡭᢑᢛᡬᢑᡪᡧ ᢊᡪᢞᡪᢊᢑᡪᢛᡳ ᢘᡪᡬᡬᢑᡭᡰᡨ";
  // Just a minor update
  static const contentNormal = "ᢔᡬᡰᡨ ᢊᡪᡲ ᡫ ᢘᡪᢙᡪᡪᡪᡳ ᡴᡭᢑᡳᡪᡳ";

  static const btnTextForced = "ᢘᡪᢙᡪᡪᡪᡳ";
  static const btnTextNormal = "ᢌᡪᢙᡪᢐᡨ";

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
          style: Theme.of(context).textTheme.displayMedium!,
        ),
        content: new MongolText(
          content,
          style: Theme.of(context).textTheme.bodyLarge!,
        ),
        actions: <Widget>[
          TextButton(
            child: MongolText(
              buttonText,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
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
