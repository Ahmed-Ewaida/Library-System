import 'package:flutter/material.dart';
import '../../../Core/constent.dart';
class BookCardWidget extends StatelessWidget {
  final String bookName;
  final String status;
  final bool isFavorited;
  const BookCardWidget({
    super.key,
    required this.bookName,
    required this.status,
    required this.isFavorited,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 60,
              decoration: BoxDecoration(
                color: blueUses,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    bookName,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                      color: status == "متوفر" ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Text('$averageRating')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
