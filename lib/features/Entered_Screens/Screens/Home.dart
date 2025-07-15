import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:t1/Features/Exam/Screens/Academic_year.dart';
import '../../../../Core/custom_appBar.dart';
import '../../../../Features/Entered_Screens/Screens/CustomScannerScreen.dart';
import '../../../../Features/Entered_Screens/Widget/enterd_card.dart';
import '../../../../features/Books/views/screens/all_books_screen.dart';
import '../../../../features/Exam/Screens/Study_program.dart';
import '../../../../features/Projects/views/screens/project_department_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static String id = "/Home";
  @override
  State<Home> createState() => _HomeState();
}

int index = 0;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomAppBar(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: const EnterdCard(
                      card_name: ' دخول المكتبة   ',
                      icon: Icons.qr_code_2,
                    ),
                    onTap: () {
                      context.push(CustomScannerScreen.id);
                    },
                  ),
                  GestureDetector(
                    onTap: () => context.push(AllBooks.id),
                    child: const EnterdCard(
                      card_name: 'الكتب                ',
                      icon: Icons.library_books_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push(AcademicYear.id);
                    },
                    child: const EnterdCard(
                      card_name: 'الامتحانات السابقة',
                      icon: Icons.playlist_add_check_circle_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push(ProjectDepartment.id),
                    child: const EnterdCard(
                      card_name: ' مشاريع التخرج      ',
                      icon: Icons.school_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
