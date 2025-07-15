import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t1/features/Projects/data/model/projects_model.dart';
import '../../../../resources_manager/network/api_helper.dart';
import '../../../../resources_manager/network/api_response.dart';
import '../../../../resources_manager/network/endpoints.dart';

class ProjectsRepo {
  ProjectsRepo._internal();

  static ProjectsRepo instance = ProjectsRepo._internal();

  static ProjectsRepo getInstance() {
    return instance;
  }

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, ProjectsModel>> getAllProjects({
    required String department,
  }) async {
    try {
      ApiResponse response = await apiHelper.getRequest(
        url: "${Endpoints.baseUrl}${Endpoints.getDepartmentProject}/$department",
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

          ProjectsModel projectsResult = ProjectsModel.fromJson(response.data);

          print("🔍 Debug - ProjectsModel status: ${projectsResult.status}");
          print("🔍 Debug - ProjectsModel data: ${projectsResult.data}");
          print("🔍 Debug - Projects list: ${projectsResult.data?.projects}");
          print("🔍 Debug - Projects count: ${projectsResult.data?.projects?.length ?? 0}");

          if (projectsResult.status == 'success') {
            print("✅ Debug - Successfully parsed projects data");
            return right(projectsResult);
          } else {
            print("❌ Debug - API returned non-success status: ${projectsResult.status}");
            return left("API returned status: ${projectsResult.status}");
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
  Future<Either<String, Projects>> getProjectDetails({
    required int projectId,
  }) async {
    try {
      // نفترض أن الرابط الخاص بجلب مشروع واحد هو /api/v1/projects/{id}
      ApiResponse response = await apiHelper.getRequest(
        url: "${Endpoints.baseUrl}api/v1/projects/$projectId",
        isAuthorized: true,
      );

      if (response.status) {
        // نتوقع أن الـ API يعيد بيانات المشروع مباشرة داخل مفتاح 'data'
        if (response.data != null && response.data['data'] != null) {
          Projects project = Projects.fromJson(response.data['data']);
          return right(project);
        } else {
          return left("Project data not found in response.");
        }
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
