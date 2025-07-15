// lib/features/Notifications/data/repo/notification_repo.dart

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t1/features/Notifications/data/model/notification_model.dart';
import '../../../../resources_manager/network/api_helper.dart';
import '../../../../resources_manager/network/api_response.dart';
import '../../../../resources_manager/network/endpoints.dart';

class NotificationRepo {
  NotificationRepo._internal();

  static final NotificationRepo _instance = NotificationRepo._internal();

  static NotificationRepo getInstance() {
    return _instance;
  }

  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<String, NotificationModel>> getNotifications() async {
    try {
      ApiResponse response = await _apiHelper.getRequest(
        url: Endpoints.baseUrl + Endpoints.getNotifications,
        isAuthorized: true,
      );

      if (response.status) {
        if (response.data == null || response.data is! Map<String, dynamic>) {
          return left("Invalid response format: data is null or not a map.");
        }
        NotificationModel notificationModel =
        NotificationModel.fromJson(response.data);
        return right(notificationModel);
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