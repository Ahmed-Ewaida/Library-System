import 'package:dio/dio.dart';

class ApiResponse {
  final bool status;
  final int statusCode;
  final dynamic data;
  final String message;

  ApiResponse({
    required this.status,
    required this.statusCode,
    this.data,
    required this.message,
  });

  factory ApiResponse.fromResponse(Response response) {
    bool extractedStatus = false;
    String extractedMessage = 'حدث خطأ غير معروف في الاستجابة.';
    dynamic extractedData;

    print("البيانات الخام للاستجابة في fromResponse: ${response.data}");
    print("كود حالة الاستجابة في fromResponse: ${response.statusCode}");

    if (response.data != null && response.data is Map<String, dynamic>) {
      Map<String, dynamic> responseMap = response.data;

      // *************************************************************
      // * التعديل هنا: تحويل 'status' من String إلى bool
      if (responseMap["status"] is String) {
        extractedStatus = (responseMap["status"] == 'success');
      } else if (responseMap["status"] is bool) {
        extractedStatus = responseMap["status"];
      } else {
        extractedStatus = false; // افتراضي إذا لم يكن النوع متوقعًا
      }
      // *************************************************************

      extractedMessage =
          responseMap["message"] ?? "لا توجد رسالة محددة من API.";

      extractedData = responseMap;
    } else if (response.data is String &&
        (response.data as String).isNotEmpty) {
      extractedMessage = response.data;
      extractedData = null;
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        extractedStatus = true;
      }
    } else {
      extractedMessage = "تنسيق استجابة فارغ أو غير متوقع.";
      extractedStatus = false;
      extractedData = null;
    }

    print("الحالة المستخلصة: $extractedStatus");
    print("الرسالة المستخلصة: $extractedMessage");

    return ApiResponse(
      status: extractedStatus,
      statusCode: response.statusCode ?? 500,
      data: extractedData,
      message: extractedMessage,
    );
  }

  factory ApiResponse.fromError(dynamic error) {
    String errorMessage = 'حدث خطأ غير متوقع.';
    int statusCode = 500;
    dynamic errorData;

    if (error is DioException) {
      if (error.response != null) {
        statusCode = error.response!.statusCode ?? 500;
        if (error.response!.data != null &&
            error.response!.data is Map<String, dynamic>) {
          errorMessage = error.response!.data["message"] ?? errorMessage;
          errorData = error.response!.data;
        } else if (error.response!.data is String) {
          errorMessage = error.response!.data;
        }
      } else {
        errorMessage = 'خطأ في الشبكة: ${error.message}';
      }
    } else {
      errorMessage = error.toString();
    }

    return ApiResponse(
      status: false,
      statusCode: statusCode,
      data: errorData,
      message: errorMessage,
    );
  }
}
