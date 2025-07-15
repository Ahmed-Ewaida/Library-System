import 'package:flutter/material.dart';

class PopUpDialog extends StatelessWidget {
  final String location;
  final String bookNumber;

  const PopUpDialog({
    Key? key,
    required this.location,
    required this.bookNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Text(
              'مكان الكتاب: $location',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 18,),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'رقم الكتاب: $bookNumber',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'تأكد من إعادة الكتاب\nفي مكانه الصحيح',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'موافق',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),


      ),
    );
  }
}
