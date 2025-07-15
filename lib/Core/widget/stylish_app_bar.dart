import 'package:flutter/material.dart';

class StylishAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const StylishAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // --- التصميم الأنيق ---
      backgroundColor: Colors.transparent, // جعل الخلفية شفافة لإظهار التدرج
      elevation: 0, // إزالة الظل الافتراضي
      flexibleSpace: Container(
        decoration: BoxDecoration(
          // تدرج لوني جذاب
          gradient: LinearGradient(
            colors: [const Color(0xFF1E88E5), Colors.blue.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      // عنوان الصفحة
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      centerTitle: true,
      // أيقونات الـ AppBar
      actions: actions ?? // في حال لم يتم توفير أيقونات، نضع أيقونة افتراضية
          [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                child: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
              ),
            ),
          ],
      // أيقونة القائمة الجانبية (Drawer)
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 30),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}