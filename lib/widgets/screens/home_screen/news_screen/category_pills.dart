import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';

class CategoryPill extends StatelessWidget {
  final String text;
  final bool isCenter;

  const CategoryPill({Key? key, required this.text, this.isCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      alignment: isCenter ? Alignment.center : Alignment.topCenter,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.green[300],
      ),
      child: MongolText(
        text,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
