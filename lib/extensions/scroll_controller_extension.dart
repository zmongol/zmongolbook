import 'package:flutter/material.dart';

extension ScrollControllerExtension on ScrollController {
  bool isEndOfPage() {
    return offset >= position.maxScrollExtent && !position.outOfRange;
  }
}
