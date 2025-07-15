import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/constent.dart';
import '../../../../features/Chat/Screen/Chat_Page.dart';
import '../../features/Books/views/screens/favbooks_screen.dart';
import '../../features/Borrow_Screens/Screens/search.dart';
import '../../features/Community/views/screens/community_screen.dart';
import '../../features/Entered_Screens/Screens/Home.dart';
// هذا المستورد غير مستخدم، يمكن حذفه إذا لم يكن له استخدامات أخرى

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static String id = "/MainScreen";

  static final List<Widget> _screens = [
    Home(),
    Search(),
    CommunityScreen(),
    Favbooks(),
    // ChatPage() -> سننتقل إليها كشاشة منفصلة
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 4) {
      context.push(ChatPage.id);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MainScreen._screens[_selectedIndex],
        bottomNavigationBar: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(100),
                spreadRadius: 0,
                blurRadius: 1,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: blueUses,
            unselectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: bottomNavItems,
          ),
        ),
      ),
    );
  }
}

List<BottomNavigationBarItem> bottomNavItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_outlined),
    label: 'الرئيسية',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search),
    activeIcon: Icon(Icons.search),
    label: 'البحث',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.group),
    activeIcon: Icon(Icons.group, color: blueUses),
    label: 'المجتمع',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite_border),
    activeIcon: Icon(Icons.favorite_border, color: blueUses),
    label: 'المفضلة',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.message_outlined),
    activeIcon: Icon(Icons.message_outlined, color: blueUses),
    label: 'الرسائل',
  ),
];
