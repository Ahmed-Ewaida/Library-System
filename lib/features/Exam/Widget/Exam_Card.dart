import 'package:flutter/material.dart';
import '../../../Core/constent.dart';
class ExamCard extends StatelessWidget {
  const ExamCard({super.key, required this.course_name, required this.department, required this.type, required this.year, required this.has_pdf});

  final String course_name;
  final String department;
  final String type;
  final int year;
  final bool has_pdf;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 2,
          blurRadius: 6,
        ),
      ], borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$department/$course_name/$type/$year'),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.upload,
                  //       size: 15,
                  //       color: blueUses,
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       has_pdf ? 'تحميل' : 'غير متاح التحميل',
                  //       style: TextStyle(
                  //         color: has_pdf ? Colors.blue : Colors.red,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //
                  //   ],
                  // )
                ],
              ),
            ),
            const Column(
              children: [
                SizedBox(
                  height: 80,
                  width: 100,
                  child: Image(
                    image: NetworkImage(
                      'https://tse3.mm.bing.net/th/id/OIP.qyip0gFDasQiIdcBiJSRiwHaJM?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    )
    ;
  }
}
