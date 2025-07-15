import 'package:dartz/dartz.dart';

import '../../../../../resources_manager/network/api_helper.dart';
import '../../../../../resources_manager/network/api_response.dart';
import '../../../../../resources_manager/network/endpoints.dart';

class AuthRepo {
  AuthRepo._internal();

  static AuthRepo instance = AuthRepo._internal();

  static getinstance() {
    return instance;
  }

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, String>> register({
    required String username,
    required String password,
    required String passwordConfirmation,
    required String universityCode,
    required int level,
    required String department,
    required String email,
    required String phone,
    required String fullname,
    required int? selectedYear, // يمكن الاحتفاظ به في المعاملات لكن لا نرسله للباك إند
  }) async {

    // إضافة debugging للتأكد من البيانات المرسلة
    final data = {
      "username": username,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "university_code": universityCode,
      "level": level,
      "department": department,
      "email": email,
      "phone_no": phone, // ✅ مُصحح - يستخدم phone_no كما يتوقع الباك إند
      "fullname": fullname,
      // ✅ تم حذف "year" لأن الباك إند لا يتوقعه
    };

    print("Sending registration data: $data");
    print("Endpoint: ${Endpoints.register}");

    ApiResponse response = await apiHelper.postRequest(
      data: data,
      isAuthorized: false,
      endPoint: Endpoints.baseUrl +Endpoints.register,
    );

    print("Response status: ${response.status}");
    print("Response message: ${response.message}");

    if (response.status) {
      return right(response.message);
    } else {
      return left(response.message);
    }
  }
}