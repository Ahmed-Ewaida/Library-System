import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../resources_manager/network/api_helper.dart';
import '../../../../resources_manager/network/api_response.dart';
import '../../../../resources_manager/network/endpoints.dart';
import '../model/all_books_model.dart';

class HomeRepo {
  HomeRepo._internal();

  static HomeRepo instance = HomeRepo._internal();

  static HomeRepo getinstance() {
    return instance;
  }

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, BooksModel>> bestSeller() async {
    try {
      ApiResponse response = await apiHelper.getRequest(
        url: Endpoints.baseUrl + Endpoints.bestSeller,
        isAuthorized: true,
      );

      print("🔍 Debug - Response status: ${response.status}");
      print("🔍 Debug - Response data type: ${response.data.runtimeType}");
      print("🔍 Debug - Response data: ${response.data}");

      if (response.status) {
        if (response.data == null || response.data is! Map<String, dynamic>) {
          print("❌ Debug - Invalid response format");
          return left("Invalid response format: data is null or not a map.");
        }

        try {
          print("🔄 Debug - Starting to parse data...");

          // هنا نمرر الـ response.data بالكامل إلى fromJson
          BooksModel booksResult = BooksModel.fromJson(response.data);

          print("🔍 Debug - BooksModel status: ${booksResult.status}");
          print("🔍 Debug - BooksModel data: ${booksResult.data}");
          print("🔍 Debug - Books list: ${booksResult.data?.books}");
          print(
            "🔍 Debug - Books count: ${booksResult.data?.books?.length ?? 0}",
          );


          // بدلاً من ذلك، نتحقق فقط من نجاح parsing
          if (booksResult.status == 'success') {
            print("✅ Debug - Successfully parsed books data");
            return right(booksResult);
          } else {
            print(
              "❌ Debug - API returned non-success status: ${booksResult.status}",
            );
            return left("API returned status: ${booksResult.status}");
          }
        } catch (e) {
          print("❌ Debug - Parsing error: ${e.toString()}");
          return left("Data parsing failed: ${e.toString()}");
        }
      } else {
        print("❌ Debug - Response status is false: ${response.message}");
        return left(response.message);
      }
    } on DioException catch (e) {
      print("❌ Debug - DioException: ${e.message}");
      return left(ApiResponse.fromError(e).message);
    } catch (e) {
      print("❌ Debug - Unexpected error: ${e.toString()}");
      return left("An unexpected error occurred: ${e.toString()}");
    }
  }
}
