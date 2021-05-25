import 'package:flutter/material.dart';

class RouteHelper {
  static openViewImageScreen(BuildContext context, {required String imageUrl}) {
    Navigator.of(context).pushNamed(
      '/viewImage',
      arguments: {
        'imageUrl': imageUrl,
      },
    );
  }
}
