import 'package:dio/dio.dart';

import '../../local.dart'; // تأكد أن هذا المسار صحيح وأن LocalData.accessToken يمكن الوصول إليه.
import 'api_response.dart';
import 'endpoints.dart';

class ApiHelper {
  static final ApiHelper _singleton = ApiHelper._internal();

  factory ApiHelper() => _singleton;

  ApiHelper._internal();

  Dio dio =
      Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl,
            connectTimeout: const Duration(
              seconds: 30,
            ), // استخدم const لـ Duration
            receiveTimeout: const Duration(
              seconds: 30,
            ), // استخدم const لـ Duration
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              // ignore: avoid_print
              print("Headers : ${options.headers.toString()}");
              // طباعة البيانات فقط إذا لم تكن فارغة وقابلة للتطبيق (على سبيل المثال، لطلبات POST/PUT)
              if (options.data != null) {
                // التحقق مما إذا كانت البيانات FormData لتجنب أخطاء التحويل لأنواع أخرى
                if (options.data is FormData) {
                  print(
                    "data : ${(options.data as FormData).fields.toString()}",
                  );
                } else {
                  print("data : ${options.data.toString()}");
                }
              }
              // ignore: avoid_print
              print("method : ${options.method}");
              // ignore: avoid_print
              print("EndPoint : ${options.path}");
              // ignore: avoid_print
              print(
                "Query Parameters : ${options.queryParameters.toString()}",
              ); // أضف هذا لطلبات GET
              return handler.next(options); // تابع الطلب
            },
            // --- تمت إضافة onError interceptor هنا ---
            onError: (DioException err, ErrorInterceptorHandler handler) {
              print("🚨 تم التقاط خطأ Dio في المُعترِض:");
              print("النوع: ${err.type}");
              print("الرسالة: ${err.message}");
              if (err.response != null) {
                print("بيانات الاستجابة: ${err.response?.data}");
                print("كود حالة الاستجابة: ${err.response?.statusCode}");
              }
              return handler.next(err); // استمر في تمرير الخطأ
            },
          ),
        );

  // --- تم تصحيح طريقة getRequest ---
  Future<ApiResponse> getRequest({
    required String url,
    Map<String, dynamic>? queryParameters, // استخدم queryParameters لـ GET فقط
    bool isAuthorized = false,
  }) async {
    try {
      var response = await dio.get(
        url,
        queryParameters: queryParameters, // تمرير المعلمات بشكل صحيح
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization":
                  "Bearer ${LocalData.accessToken}", // تم إلغاء التعليق
          },
        ),
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      // تمرير الخطأ مباشرة إلى ApiResponse.fromError دون تحويل صريح.
      // ApiResponse.fromError سيتعامل مع أنواع الأخطاء المختلفة.
      print("تم التقاط استثناء في getRequest: $e");
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.post(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
        ),
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      // تمرير الخطأ مباشرة
      print("تم التقاط استثناء في postRequest: $e");
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> putRequest({
    required String url,
    dynamic data,
    bool isFormdata = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.put(
        url,
        data: isFormdata ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
        ),
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      // تمرير الخطأ مباشرة
      print("تم التقاط استثناء في putRequest: $e");
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> deleteRequest({
    required String url,
    Map<String, dynamic>? data,
    bool isFormdata = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.delete(
        url,
        data: isFormdata ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
        ),
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      // تمرير الخطأ مباشرة
      print("تم التقاط استثناء في deleteRequest: $e");
      return ApiResponse.fromError(e);
    }
  }
}
