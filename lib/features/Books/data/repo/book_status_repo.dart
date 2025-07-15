// lib/features/Notifications/data/repo/notification_repo.dart

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t1/features/Notifications/data/model/notification_model.dart';
import '../../../../resources_manager/network/api_helper.dart';
import '../../../../resources_manager/network/api_response.dart';
import '../../../../resources_manager/network/endpoints.dart';
import '../model/book_status_model.dart';

class BookstatusRepo {
  BookstatusRepo._internal();

  static final BookstatusRepo _instance = BookstatusRepo._internal();

  static BookstatusRepo getInstance() {
    return _instance;
  }

  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<String, BookStatusModel>> getBookstatus(
       {required int bookId}
      ) async {
    try {
      ApiResponse response = await _apiHelper.getRequest(

        // /api/v1/books/1/status
        url: Endpoints.baseUrl + "api/v1/books/"+bookId.toString()+"/status",
        isAuthorized: true,
      );

      if (response.status) {
        if (response.data == null || response.data is! Map<String, dynamic>) {
          return left("Invalid response format: data is null or not a map.");
        }

        BookStatusModel bookStatusModel =
        BookStatusModel.fromJson(response.data);
        return right(bookStatusModel);
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