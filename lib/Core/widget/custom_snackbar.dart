import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
    BuildContext context,
    String message,
    Color backgroundColor, [
      IconData? icon,
    ]) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(12),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // الأيقونة على اليمين في اللغة العربية
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
          ],
          // النص داخل Expanded علشان ما يضربش Overflow
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    ),
  );
}

