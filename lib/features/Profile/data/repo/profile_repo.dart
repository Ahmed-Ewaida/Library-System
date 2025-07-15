import 'package:dartz/dartz.dart';
import 'package:t1/features/Profile/data/model/profile_model.dart';
import '../../../../resources_manager/network/api_helper.dart';
import '../../../../resources_manager/network/api_response.dart';
import '../../../../resources_manager/network/endpoints.dart';

class ProfileRepo {
  ProfileRepo._internal();

  static ProfileRepo instance = ProfileRepo._internal();

  static getinstance() {
    return instance;
  }

  ApiHelper apiHelper = ApiHelper();


  Future<Either<String, ProfileModel>> getUserData() async {
    ApiResponse response = await apiHelper.getRequest(
      url: Endpoints.baseUrl + Endpoints.getuserData,
      isAuthorized: true,
    );

    if (response.status) {
      ProfileModel responseModel = ProfileModel.fromJson(response.data!);
      return right(responseModel);
    } else {
      return left(response.message);
    }
  }
}