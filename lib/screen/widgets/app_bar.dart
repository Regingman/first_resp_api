import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'University',
      style: TextStyle(
        fontSize: 28.0,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
