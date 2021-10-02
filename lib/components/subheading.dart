import 'package:flutter/material.dart';


class SubHeading extends StatelessWidget {

  SubHeading({
    Key? key, required this.subtitle
  }) : super(key: key);

  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: const TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.4,
        fontSize: 22.0,
      ),
    );
  }
}