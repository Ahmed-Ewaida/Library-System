// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// class BackArrow extends StatelessWidget {
//   const BackArrow({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: GestureDetector(
//         onTap: () => context.pop(), // يعود للصفحة السابقة
//         child: const Icon(Icons.arrow_back, size: 30),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        context.pop(); // لو شغالة بـ go_router
      },
    );
  }
}
