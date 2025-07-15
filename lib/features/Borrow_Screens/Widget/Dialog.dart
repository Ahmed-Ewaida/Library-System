// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:testt/features/Authontication/login/data/repo/login_repo.dart';
// import '../../../../Core/constent.dart';
// import '../../../../Core/Push_button.dart';
// import '../../../API services/borrow_service.dart';
// import '../../../local.dart';
//
// void showFirstDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           AlertDialog(
//             alignment: Alignment.center,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15), // لجعل الحواف مستديرة
//             ),
//             title: const Text(
//               "يرجى التوجه إلى المكتبة خلال 24 ساعة من الموافقة على طلبك",
//             ),
//             actions: [
//               Row(
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       showSecondDialog(context);
//                     },
//                     child: const PushButton(
//                       width: 90,
//                       nameCard: "تأكيد الطلب",
//                       fontSize: 15,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const PushButton(
//                       width: 90,
//                       nameCard: "إلغاء الطلب",
//                       fontSize: 15,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       );
//     },
//   );
// }
// void showSecondDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("تم إرسال طلبك بنجاح"),
//         content: const Text("انتظر الرد", style: TextStyle(fontSize: 20)),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context); // قفل الديالوج
//               final token = LocalData.accessToken;
//               final success = await BorrowService().sendRequest();
//               print("بيبدأ إرسال الطلب...");
//               print("تمت العملية؟ $success");
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(success
//                       ? 'تم إرسال الطلب بنجاح'
//                       : 'فشل في إرسال الطلب'),
//                 ),
//               );
//             },
//             child: Text('إرسال'),
//           ),
//         ],
//       );
//     },
//   );
// }
//
// // void showFirstDialog(BuildContext context) {
// //   showDialog(
// //     context: context,
// //     builder: (context) {
// //       return AlertDialog(
// //         title: Text('تأكيد الطلب'),
// //         content: Text('هل أنت متأكد من إرسال طلب الاستعارة؟'),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: Text('إلغاء'),
// //           ),
// //           TextButton(
// //             onPressed: () async {
// //               Navigator.pop(context); // قفل الديالوج
// //               final token = LocalData.accessToken;
// //               final success = await BorrowService().sendRequest(token!);
// //               print("بيبدأ إرسال الطلب...");
// //               print("تمت العملية؟ $success");
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 SnackBar(
// //                   content: Text(success
// //                       ? 'تم إرسال الطلب بنجاح'
// //                       : 'فشل في إرسال الطلب'),
// //                 ),
// //               );
// //             },
// //             child: Text('إرسال'),
// //           ),
// //         ],
// //       );
// //     },
// //   );
// // }
// //
