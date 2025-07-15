import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  const UserData({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}
