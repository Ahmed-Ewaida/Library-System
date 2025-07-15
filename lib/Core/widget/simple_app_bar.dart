import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SimpleAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // --- التصميم البسيط والأنيق ---
      backgroundColor: Colors.white, // خلفية بيضاء نظيفة
      elevation: 0.5, // ظل خفيف جداً لفصله عن المحتوى
      shadowColor: Colors.grey[300],
      // --- عنوان الصفحة في المنتصف ---
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF333333), // لون نص داكن وواضح
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      // --- زر الرجوع ---
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF333333), // نفس لون النص للانسجام
        ),
        onPressed: () {
          // للرجوع إلى الشاشة السابقة
          context.pop();
        },
      ),
      // هذا السطر لإزالة أي أزرار إضافية تلقائياً
      actions: const [SizedBox.shrink()],
    );
  }

  @override
  // تحديد الارتفاع القياسي للـ AppBar
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}