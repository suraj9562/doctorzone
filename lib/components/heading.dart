import 'package:flutter/material.dart';

class Heading extends StatelessWidget {

  Heading({
    Key? key, required this.title,
  }) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.4),
    );
  }
}