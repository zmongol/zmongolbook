import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImageScreen extends StatelessWidget {

  final String imageUrl;

  const ViewImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        color: Colors.black,
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
