import 'package:flutter/material.dart';
import '../../../Core/constent.dart';

class CustomOptionTile extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomOptionTile({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: blueUses,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
