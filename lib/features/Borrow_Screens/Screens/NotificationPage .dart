// import 'package:flutter/material.dart';
// import '../../../../Core/Back_Arrow.dart';
// import '../../../../Core/custom_appBar.dart';
//
// class NotificationPage extends StatefulWidget {
//   const NotificationPage({super.key});
//   // static String id = "/NotificationPage";
//
//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomAppBar(),
//             const BackArrow(),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   'الإشعارات',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.right,
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text(
//                     'تمت الموافقة على طلب الاستعارة توجه لأمينة المكتبة لاستلام الكتاب',
//                     style: TextStyle(fontSize: 16, height: 1.5),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
