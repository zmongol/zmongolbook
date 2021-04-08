
import 'package:flutter/material.dart';
import './single_item.dart';

class HorizontalItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        constraints: new BoxConstraints(
          minHeight: 35.0,
          maxHeight: 250.0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 12,
          itemBuilder: (context, index) {
            return SingleItem(index, 'ᡥᢛᡪᡧ ᢚᡬᡪᢊᢊᡬᢓ ᡭᡧ ᡥᡭᡬᡫᡨ ᡬᡬᡧ ᡥᡭᡬᡬᡱᡱᡭᢞᢛᡬᡧ ᡳᡬᢚᡬᡬᡨ ᢜᡭᡬᡱᡬᢥᡭᢙᡦ ᢙᡳ ᡳᡪᢙᡭᢑᡪᡪᡪᢙᡪᡪᡪᡳ ᡴᡭᢑᡭᢐᡨ');
          },
        ),
      ),
    );
  }
}
