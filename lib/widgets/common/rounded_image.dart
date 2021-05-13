import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final double size;
  final double radius;
  final BoxFit fit;
  final String imageUrl;

  const RoundedImage(
      {Key? key,
      required this.size,
      this.fit = BoxFit.cover,
      required this.imageUrl,
      this.radius = 16.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child:
          Image.network(imageUrl, fit: BoxFit.cover, height: size, width: size),
    );
  }
}
