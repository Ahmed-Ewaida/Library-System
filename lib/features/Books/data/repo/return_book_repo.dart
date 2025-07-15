import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t1/features/Books/data/model/return_book_model.dart';
import '../../../../resources_manager/network/api_helper.dart';
import '../../../../resources_manager/network/api_response.dart';
import '../../../../resources_manager/network/endpoints.dart';

class ReturnBookRepo {
  ReturnBookRepo._internal();

  static ReturnBookRepo instance = ReturnBookRepo._internal();

  static ReturnBookRepo getInstance() {
    return instance;
  }

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, ReturnBookModel>> getReturnBooks() async {
    try {
      ApiResponse response = await apiHelper.getRequest(
        url: Endpoints.baseUrl + Endpoints.getBookRequests,
        isAuthorized: true,
      );

      if (response.status) {
        if (response.data == null || response.data is! Map<String, dynamic>) {
          return left("Invalid response format: data is null or not a map.");
        }
        ReturnBookModel returnBookModel = ReturnBookModel.fromJson(response.data);
        return right(returnBookModel);
      } else {
        return left(response.message);
      }
    } on DioException catch (e) {
      return left(ApiResponse.fromError(e).message);
    } catch (e) {
      return left("An unexpected error occurred: ${e.toString()}");
    }
  }

  // 🚀 الدالة الجديدة لإرجاع الكتاب
  Future<Either<String, String>> returnBook({required int requestId}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        // بناء الرابط مع تضمين الـ ID
        endPoint: "${Endpoints.baseUrl}${Endpoints.createBookRequest}/$requestId/return",
        isAuthorized: true,
        data: {}, // لا نرسل بيانات في الـ body
      );

      if (response.status) {
        return right(response.message);
      } else {
        return left(response.message);
      }
    } on DioException catch (e) {
      return left(ApiResponse.fromError(e).message);
    } catch (e) {
      return left("An unexpected error occurred: ${e.toString()}");
    }
  }
}