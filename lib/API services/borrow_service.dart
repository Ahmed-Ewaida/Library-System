import 'dart:io';
import 'package:dio/dio.dart';

import '../Core/constent.dart';
import '../local.dart';
class BorrowService {
  final Dio _dio = Dio();
  Future<bool> sendRequest({
    required int bookId,
    required File imageFile,
    required File pdfFile,
  }) async {
    try {
      String url = '$baseURl/api/v1/book-requests';
      final token = LocalData.accessToken;
      if (token == null) {
        print("التوكن غير موجود");
        return false;
      }// غيّريه حسب API بتاعكم
      FormData formData =FormData.fromMap({
        'book_id':bookId,
        'type':'borrowing',
        'id_card_image':await MultipartFile.fromFile(imageFile.path,filename: 'image.jpg'),
        'eagle_seal_document':await MultipartFile.fromFile(pdfFile.path, filename: 'document.pdf'),
      });
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          })
      );
      print("الرد من السيرفر: ${response.statusCode}");
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      if (e is DioException && e.response != null) {
        print('خطأ في الإرسال: ${e.response?.data}');
      }else{
        print('خطأ في الإرسال: $e');
      }
      return false;
    }}
}