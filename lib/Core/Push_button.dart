import 'package:flutter/material.dart';

import '../features/constent.dart';
class PushButton extends StatelessWidget {
  const PushButton({
    super.key,
    required this.width,
    required this.fontSize,
    required this.nameCard,
    this.isLoading = false,
  });

  final double width;
  final double fontSize;
  final String nameCard;
  final bool isLoading;

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
        child: isLoading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2.5,
          ),
        )
            : Text(
          nameCard,
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
      ),
    );
  }
}
