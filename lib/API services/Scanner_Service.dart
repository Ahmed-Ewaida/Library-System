import 'package:dio/dio.dart';
import '../API models/Scanner_model.dart';
import '../Core/constent.dart';
import '../local.dart';

class ScannerService{
  static final Dio dio =Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20)
  ));
  static Future<Response> postScanData( ScannerModel model )async{
    String url ='$baseURl/api/v1/visits/scan';
    final token= LocalData.accessToken;
    if(token==null){
      print('⚠️ Token غير موجود');
      throw Exception('Token غير موجود');
    }
    try {
      final response = await dio.post(
          url,
          data: model.toJson(),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            'Content-Type': 'application/json',
          }
        )
      );
      print("الرد من السيرفر: ${response.statusCode}");
      return response;
    } on DioException catch (e) {
      print(' ❌ خطأ في الاتصال بالسيرفر ${e.response?.statusCode} - ${e.message}');
      throw Exception('❌ خطأ في الاتصال بالسيرفر');
      // TODO
    }catch (e){
      print(" ❌ خطا غير متوقع$e ");
      throw Exception(' ❌ خطا غير متوقع');
    }
  }
}