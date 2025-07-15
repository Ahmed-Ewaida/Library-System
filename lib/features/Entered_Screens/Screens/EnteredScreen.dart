import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:t1/Features/Exam/Screens/Academic_year.dart';
import '../../../../Features/Chat/Screen/Chat_Page.dart';
import '../../../../features/Books/views/screens/all_books_screen.dart';
import '../../../../features/Books/views/screens/favbooks_screen.dart';
import '../../../../features/Borrow_Screens/Screens/search.dart';
import '../../../../features/Community/views/screens/community_screen.dart';
import '../../../../features/Exam/Screens/Study_program.dart';
import '../../../../features/Projects/data/model/projects_model.dart';
import '../../../../features/Projects/views/screens/project_department_screen.dart';
import '../../../../features/Projects/views/screens/projects_screen.dart';
import '../../../../Core/custom_appBar.dart';
import '../../../../Features/Entered_Screens/Widget/enterd_card.dart';

import '../../../Core/constent.dart';
import 'Home.dart';

class EnteredScreen extends StatefulWidget {
  const EnteredScreen({super.key});
  static String id = "/EnteredScreen";
  @override
  State<EnteredScreen> createState() => _EnteredScreenState();
}
int index = 0;


class _EnteredScreenState extends State<EnteredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomAppBar(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  card_name: 'الامتحانات السابقة    ',
                  icon: Icons.checklist,
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
        ],
      ),
    bottomNavigationBar: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
      currentIndex: index,
      onTap: (int newIndex) {
        setState(() {
          index = newIndex;
        });
        switch (newIndex) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go(Search.id);
            break;
          case 2:
          context.go(CommunityScreen.id);
            break;
          case 3:
          context.go(Favbooks.id);
            break;
          case 4:
            context.push(ChatPage.id);
            break;
        }
      },
      selectedItemColor: blueUses,
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'البحث',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'المجتمع',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'المفضلة',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          label: 'الرسائل',
        ),
      ],
    ),
    );
  }
}
