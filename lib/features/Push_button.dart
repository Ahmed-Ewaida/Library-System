import 'package:flutter/material.dart';
import '../../../../Core/constent.dart';

class PushButton extends StatelessWidget {
  const PushButton({
    super.key,
    required this.width,
    required this.fontSize,
    required this.nameCard,
  });
  final double width;
  final double fontSize;
  final String nameCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        color: blueUses,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          nameCard,
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
      ),
    );
  }
}
