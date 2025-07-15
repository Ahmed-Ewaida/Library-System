import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t1/features/Books/data/model/book_requests_model.dart';
import 'package:t1/features/Books/data/model/book_requests_response.dart';
import '../../../../resources_manager/network/api_helper.dart';
import '../../../../resources_manager/network/api_response.dart';
import '../../../../resources_manager/network/endpoints.dart';
import '../../../../local.dart';

class BookRequestRepo {
  BookRequestRepo._internal();

  static final BookRequestRepo _instance = BookRequestRepo._internal();

  static BookRequestRepo getInstance() {
    return _instance;
  }

  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<String, BookRequestResponseModel>> createBookRequest(
      BookRequests requestPayload) async {
    try {
      // إزالة studentId تماماً من الـ request
      final data = {
        "book_id": requestPayload.bookId,
        "type": requestPayload.type,
        "due_date": requestPayload.dueDate,
      };

      print("Request data: $data"); // للتأكد من البيانات

      ApiResponse response = await _apiHelper.postRequest(
        endPoint: Endpoints.baseUrl + Endpoints.createBookRequest,
        data: data,
        isAuthorized: true,
      );

      print("Response status: ${response.status}"); // للتأكد من الاستجابة
      print("Response data: ${response.data}"); // للتأكد من البيانات

      if (response.status) {
        if (response.data == null) {
          return left("Response data is null");
        }

        // التحقق من نوع البيانات قبل التحويل
        if (response.data is! Map<String, dynamic>) {
          print("Response data type: ${response.data.runtimeType}");
          return left("Invalid response format: expected Map<String, dynamic>, got ${response.data.runtimeType}");
        }

        BookRequestResponseModel responseModel =
        BookRequestResponseModel.fromJson(response.data as Map<String, dynamic>);
        return right(responseModel);
      } else {
        return left(response.message);
      }
    } on DioException catch (e) {
      print("DioException: ${e.toString()}"); // للتأكد من نوع الخطأ
      return left(ApiResponse.fromError(e).message);
    } catch (e) {
      print("General Exception: ${e.toString()}"); // للتأكد من نوع الخطأ
      return left("An unexpected error occurred: ${e.toString()}");
    }
  }
}