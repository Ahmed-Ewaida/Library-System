import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  static int? studentId;
  static String? studentName; // ١. أضفنا متغيرًا لاسم المستخدم
  static String? accessToken;
  // static String? refreshToken; // Not available in your current LoginRespons model

  // ٢. تحديث دالة الحفظ لتشمل اسم المستخدم
  static Future<void> saveUserData({
    required int id,
    required String name,
    required String token,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('studentId', id);
    await prefs.setString('studentName', name);
    await prefs.setString('accessToken', token);

    studentId = id;
    studentName = name;
    accessToken = token;
  }

  // ٣. تحديث دالة التحميل
  static Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentId = prefs.getInt('studentId');
    studentName = prefs.getString('studentName');
    accessToken = prefs.getString('accessToken');
  }

  // ٤. تحديث دالة المسح
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('studentId');
    await prefs.remove('studentName');
    await prefs.remove('accessToken');
    studentId = null;
    studentName = null;
    accessToken = null;
  }
}