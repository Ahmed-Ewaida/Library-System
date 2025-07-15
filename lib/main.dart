import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Core/GoRouter.dart' as AppRouter;
import 'features/Authontication/login/manager/login_cubit/login_cubit.dart';
import 'features/Authontication/register/manager/register_cubit/register_cubit.dart';
import 'features/Books/manager/all_books_cubit/cubit/all_books_cubit.dart';
import 'features/Books/manager/book_request_cubit/book_request_cubit.dart';
import 'features/Books/manager/book_status_cubit/book_status_cubit.dart';
import 'features/Books/manager/fav_manager/favorites_manager.dart';
import 'features/Books/manager/read_manager/read_manager.dart';
import 'features/Books/manager/return_action_cubit/return_action_cubit.dart';
import 'features/Books/manager/return_book_cubit/return_book_cubit.dart';
import 'features/Community/manager/community_manager.dart';
import 'features/Notifications/manager/cubit/notification_cubit.dart';
import 'features/Profile/manager/cubit/profile_cubit.dart';
import 'features/Projects/manager/cubit/progect_cubit.dart';
import 'features/Projects/manager/cubit/project_details_cubit.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const FciZuLibrary());
}

class FciZuLibrary extends StatelessWidget {
  const FciZuLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    // نستخدم MultiProvider لتوفير كل المديرين والكيوبتات للتطبيق
    return MultiProvider(
      providers: [
        // ✅ توفير مدير المفضلة الجديد في أعلى نقطة في التطبيق
        // سيتم إنشاء نسخة واحدة ومشاركتها في كل الشاشات
        ChangeNotifierProvider(create: (context) => FavoritesManager()),

        // --- باقي الـ Providers الموجودة لديك ---
        ChangeNotifierProvider(create: (context) => ReadManager()),
        // ChangeNotifierProvider(create: (context) => CommunityManager()),
        ChangeNotifierProvider(create: (context) => CommunityManager()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => AllBooksCubit()),
        BlocProvider(create: (context) => AllProjectsCubit()),
        BlocProvider(create: (context) => BookRequestCubit()),
        BlocProvider(create: (context) => ReturnBookCubit()),
        BlocProvider(create: (context) => ReturnActionCubit()),
        BlocProvider(create: (context) => BookStatusCubit()),
        BlocProvider(create: (context) => ProjectDetailsCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: MaterialApp.router(
        locale: const Locale('ar'), // 1. تحديد اللغة الافتراضية للتطبيق (العربية)
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar'), // 2. قائمة اللغات التي يدعمها التطبيق
          Locale('en'), // يمكنك إضافة الإنجليزية إذا أردت دعم اللغتين
        ],
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'Fci_Zu_Library',
      ),
    );
  }
}