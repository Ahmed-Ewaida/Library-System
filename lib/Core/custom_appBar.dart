import 'package:dartz/dartz.dart' as StudyProgram;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../Features/Exam/Screens/Academic_year.dart';
import '../../../../Core/widget/constant.dart';
import '../../../../Core/widget/main_screen.dart';
import '../../../../features/Profile/views/screens/profile_screen.dart';
import '../Features/Exam/Screens/Exam_ListView.dart';
import '../features/Books/views/screens/all_books_screen.dart';
import '../features/Books/views/screens/read_menu_screen.dart';
import '../features/Books/views/screens/return_book.dart';
import '../features/Exam/Screens/Study_program.dart';
import '../features/Notifications/views/screens/notification_screen.dart';
import '../features/Projects/views/screens/project_department_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 1),
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: AppBar(
        leading: InkWell(
          onTap: () {
            context.push(ProfileScreen.id);
          },
          child: const Icon(Icons.person_outline),
        ),
        centerTitle: true,
        title: Text(
          AppText.app_name,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              print('Selected: $result');
            },
            icon: const Icon(Icons.menu),
            color: Colors.white,
            // shadowColor: Colors.grey,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'الرئيسية',
                child: const Text('الرئيسية'),
                onTap: () {
                  context.pushReplacement(MainScreen.id);
                },
              ),
              PopupMenuItem<String>(
                value: 'الإشعارات',
                child: const Text('الإشعارات'),
                onTap: () {
                  context.push(NotificationScreen.id);
                },
              ),
              PopupMenuItem<String>(
                value: 'كل الكتب',
                child: const Text('كل الكتب'),
                onTap: () {
                  context.push(AllBooks.id);
                },
              ),

              PopupMenuItem<String>(
                value: 'إعادة كتاب',
                child: const Text('إعادة كتاب'),
                onTap: () {
                  context.push(ReturnBook.id);
                },
              ),
              PopupMenuItem<String>(
                value: 'قائمة القراءه',
                child: const Text('قائمة القراءه'),
                onTap: () {
                  context.push(ReadMenu.id);
                },
              ),
              PopupMenuItem<String>(
                value: 'إختبارات سابقه',
                child: const Text('إختبارات سابقه'),
                onTap: () {
                  context.push(AcademicYear.id);
                },
              ),
              PopupMenuItem<String>(
                value: 'مشاريع التخرج',
                child: const Text('مشاريع التخرج'),
                onTap: () {
                  context.push(ProjectDepartment.id);
                },
              ),
              PopupMenuItem<String>(
                value: 'تسجيل الخروج',
                child: const Text('تسجيل الخروج'),
                onTap: () {
                  context.pushReplacement('/');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
