import 'package:flutter/material.dart';

class DepartmentCard extends StatelessWidget {
  final String departmentName;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  const DepartmentCard({
    super.key,
    required this.departmentName,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        height: 80, // ارتفاع مناسب للبطاقة
        decoration: BoxDecoration(
          gradient: gradient, // استخدام التدرج اللوني
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // أيقونة وسهم الدخول
            Row(
              children: [
                const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Icon(icon, color: Colors.white, size: 30),
              ],
            ),
            // اسم القسم
            Text(
              departmentName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}