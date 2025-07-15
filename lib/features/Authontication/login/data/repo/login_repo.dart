import 'package:dartz/dartz.dart';

import '../../../../../local.dart';
import '../../../../../resources_manager/network/api_helper.dart';
import '../../../../../resources_manager/network/api_response.dart';
import '../../../../../resources_manager/network/endpoints.dart';
import '../model/login_response_model.dart';

class LoginRepo {
  LoginRepo._internal();

  static LoginRepo instance = LoginRepo._internal();

  static getinstance() {
    return instance;
  }

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, Data>> login({
    required String name,
    required String password,
    required String email,
  }) async {
    ApiResponse response = await apiHelper.postRequest(
      data: {"username": name, "password": password, "email": email},
      isAuthorized: false,
      endPoint: Endpoints.baseUrl + Endpoints.login,
    );

    if (response.status) {
      LoginRespons loginResponseModel = LoginRespons.fromJson(response.data!);
      if (loginResponseModel.data == null || loginResponseModel.data!.student == null || loginResponseModel.data!.token == null) {
        return left(response.message);
      }

      // -- ✨ التعديل الأساسي هنا ✨ --
      // حفظ بيانات المستخدم بما في ذلك الاسم والتوكن
      await LocalData.saveUserData(
        id: loginResponseModel.data!.student!.studentId!,
        name: loginResponseModel.data!.student!.username!, // حفظ اسم المستخدم
        token: loginResponseModel.data!.token!,
      );
      // -- نهاية التعديل --

      return right(loginResponseModel.data!);
    } else {
      return left(response.message);
    }
  }
}