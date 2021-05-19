import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Icon(
          Icons.logout,
          color: Colors.black,
          size: 32,
        ),
      ),
    );
  }
}
