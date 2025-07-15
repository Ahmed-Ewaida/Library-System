abstract class Endpoints {
  // تم تحديث baseUrl ليتطابق مع الـ API الخاص بك
  static const String baseUrl =
      'https://graduationproject-production-2d0d.up.railway.app/';
  // تم تحديث bestSeller ليتطابق مع مسار الـ API الخاص بالكتب
  static const String bestSeller = 'api/v1/books';
  static const String getBookRequests = 'api/v1/book-requests';

  // احتفظ بنقاط النهاية الأخرى إذا كانت لا تزال قابلة للتطبيق على واجهة برمجة تطبيقات التجارة الإلكترونية NTI الخاصة بك
  static const String getUserData = 'get_user_data';
  static const String register = "api/v1/auth/register"; // 💡 تم إزالة الشرطة المائلة الأمامية
  static const String login = "api/v1/auth/login";
  static const String getDepartmentProject="api/v1/projects/department";
  static const String logout = "logout";
  static const String updateProfile = "update_profile";
  static const String addToFavorite = "add_to_favorite";
  // static const String bestSeller = "best_seller_products"; // REMOVE or COMMENT OUT this line
  static const String topRated = "top_rated_products";
  static const String refreshToken = "refresh_token";
  static const String getuserData = "api/v1/auth/profile";
  static const String csDepartment = "api/v1/departments/CS";
  static const String itDepartment = "api/v1/departments/it";
  static const String createBookRequest = "api/v1/book-requests";
  static const String getNotifications = "api/v1/notifications";
  // static const String returnBookRequest = "api/v1/book-requests";

}
