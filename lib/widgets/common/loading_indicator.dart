import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {

  final Color? color;
  final Alignment? alignment;

  LoadingIndicator({
    this.color, this.alignment
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: this.alignment ?? Alignment.center,
        child: Container(
            width: 32.0,
            height: 32.0,
            child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(this.color ?? Colors.black54)
            )
        )
    );
  }
}
