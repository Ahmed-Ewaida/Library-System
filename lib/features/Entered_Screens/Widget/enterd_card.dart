import 'package:flutter/material.dart';
import '../../../../Core/constent.dart';

class EnterdCard extends StatelessWidget {
  const EnterdCard({super.key, required this.card_name, required this.icon});
  final String card_name;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345,
      height: 80,
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        border: Border.all(color: blueUses, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              card_name,
              style: TextStyle(color: blueUses, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(icon, size: 35, color: blueUses),
          ),

        ],
      ),
    );
  }
}
