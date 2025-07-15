import 'package:dartz/dartz.dart' as ReadRecord;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Core/widget/main_screen.dart';
import '../Features/Chat/Screen/Chat_Page.dart';
import '../Features/Entered_Screens/Screens/CustomScannerScreen.dart';
import '../Features/Entered_Screens/Screens/EnteredScreen.dart';
import '../Features/Entered_Screens/Screens/Home.dart';
import '../Features/Exam/Screens/Academic_year.dart';
import '../Features/Exam/Screens/Exam_ListView.dart';
import '../Features/Exam/Screens/Study_program.dart';
import '../features/Authontication/views/screens/login_screen.dart';
import '../features/Authontication/views/screens/register_screen.dart';
import '../features/Authontication/views/screens/welcome_screen.dart';
import '../features/Books/data/model/all_books_model.dart';
import '../features/Books/views/screens/all_books_screen.dart';
import '../features/Books/views/screens/book_details_screen.dart';
import '../features/Books/views/screens/book_status_screen.dart';
import '../features/Books/views/screens/favbooks_screen.dart';
import '../features/Books/views/screens/read_menu_screen.dart';
import '../features/Books/views/screens/return_book.dart';
import '../features/Borrow_Screens/Screens/Borrowing_Info.dart';
import '../features/Borrow_Screens/Screens/search.dart';
import '../features/Community/views/screens/add_post_screen.dart';
import '../features/Community/views/screens/comments_screen.dart';
import '../features/Community/views/screens/community_screen.dart';
import '../features/Exam/Screens/Department.dart';
import '../features/Exam/Screens/ExamView.dart';
import '../features/Exam/Screens/Semester.dart';
import '../features/Notifications/views/screens/notification_screen.dart';
import '../features/Profile/views/screens/profile_screen.dart';
import '../features/Projects/data/model/projects_model.dart';
import '../features/Projects/views/screens/pdf_viewer_screen.dart';
import '../features/Projects/views/screens/project_department_screen.dart';
import '../features/Projects/views/screens/project_detail_screen.dart';
import '../features/Projects/views/screens/projects_screen.dart';
final GoRouter router = GoRouter(
  initialLocation: WelcomeScreen.id,
  routes: [
    GoRoute(
      path: WelcomeScreen.id,
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      path: MainScreen.id,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: Home.id,
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: AllBooks.id,
      builder: (context, state) => const AllBooks(),
    ),
    GoRoute(
      path: CustomScannerScreen.id,
      builder: (context, state) => const CustomScannerScreen(),
    ),
    GoRoute(
      path: Search.id,
      builder: (context, state) {
        return const Search();
      },
    ),
    GoRoute(
      path: EnteredScreen.id,
      builder: (context, state) => const EnteredScreen(),
    ),
    // GoRoute(
    //   path: StudyProgram.id,
    //   builder: (context, state) => const StudyProgram(),
    // ),
    GoRoute(
      path: AcademicYear.id, //
      builder: (context, state) {

        return const AcademicYear();
      },
    ),
    GoRoute(
      path: Semester.id,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final yearId = data['yearId'];
        return Semester(
          yearId: yearId,
        );
      },
    ),
    GoRoute(
      path: NotificationScreen.id,
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: Departments.id,
      builder: (context, state) {
        final extraData = state.extra as Map<String, dynamic>;
        return Departments(
          extraData: extraData,
        );
      },
    ),

    GoRoute(
      path: ExamListview.id,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>; // <-- لازم النوع يكون Map
        return ExamListview(data: data); // <-- مرريها هنا
      },
    ),

    GoRoute(
      path: ChatPage.id,
      builder: (context, state) => const ChatPage(),
    ),
    GoRoute(
      path: LoginScreen.id,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RegisterScreen.id,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: ProfileScreen.id,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: BookDetailsScreen.id,
      builder: (context, state) {
        final book = state.extra as Books;
        return BookDetailsScreen(books: book);
      },
    ),
    GoRoute(
      path: BookStatus.id,
      builder: (context, state) {
        final book = state.extra as Books;
        return BookStatus(book: book);
      },
    ),

    GoRoute(
      path: Favbooks.id,
      builder: (context, state) => const Favbooks(),
    ),
    GoRoute(
      path: ProjectsScreen.id,
      builder: (context, state) {
        final departmentId = state.extra as String?;
        return ProjectsScreen(departmentId: departmentId);
      },
    ),
    GoRoute(
      path: ProjectDepartment.id,
      builder: (context, state) => ProjectDepartment(),
    ),
    // ✅ التصحيح هنا - استقبال Projects بدلاً من ProjectsModel
    GoRoute(
      path: ProjectDetails.id,
      builder: (context, state) {
        // ✅ الخطوة 1: استقبل الرقم الذي تم إرساله
        final projectId = state.extra as int;

        // ✅ الخطوة 2: قم بتمرير الرقم إلى شاشة التفاصيل
        return ProjectDetails(projectId: projectId);
      },
    ),
    GoRoute(
      path: PdfViewerScreen.id,

      builder: (context, state) {
        final String pdfUrl = state.extra as String;
        return PdfViewerScreen(pdfUrl: pdfUrl,);
      }
    ),
    GoRoute(
      path: ReadMenu.id,
      builder: (context, state) => const ReadMenu(),
    ),
    GoRoute(
      path: ReturnBook.id,
      builder: (context, state) => const ReturnBook(),
    ),
    GoRoute(
      path: FirstScreen.screenId,
      builder: (context, state) => const FirstScreen(),
    ),
    GoRoute(
      path: CommentsScreen.commentId,
      builder: (context, state) => const CommentsScreen(postId: '',),
    ),
    GoRoute(
      path: BorrowRequestPage.id,
      builder: (context, state)  {
        final book =state.extra as int;
        return BorrowRequestPage(BookID: book,);
      } ,
    ),
    GoRoute(
      path: CommunityScreen.id,
      builder: (context, state) =>  const CommunityScreen(),
    ),
    GoRoute(
      path: ExamView.id,
      builder: (context,state)=> const ExamView(),
    )
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(child: Text('Page not found: ${state.error}')),
  ),
);