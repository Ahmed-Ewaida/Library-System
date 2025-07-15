// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:graduation_project/Core/widget/constant.dart';
// import 'package:graduation_project/features/Community/views/screens/add_post_screen.dart';

// import '../../features/Profile/views/screens/profile_screen.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       title: Text(
//         AppText.app_name,
//         style: TextStyle(
//           color: Colors.red,
//           fontWeight: FontWeight.bold,
//           fontSize: 22,
//         ),
//       ),
//       centerTitle: true,
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.account_circle, color: Colors.grey, size: 30),
//           onPressed: () {
//             context.push(ProfileScreen.id);

//             // Navigator.pushNamed(context, ProfileScreen.id);
//           },
//         ),
//       ],
//       leading: const Icon(Icons.menu, color: Colors.black),
//       flexibleSpace: Stack(
//         children: [
//           Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               height: 1,
//               color: Colors.black,
//               width: double.infinity,
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: 0.5,
//               color: Colors.grey,
//               width: double.infinity,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }
