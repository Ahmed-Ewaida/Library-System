import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/features/Projects/manager/cubit/progect_state.dart';

import '../../data/model/projects_model.dart';
import '../../data/repo/projects_repo.dart';

class AllProjectsCubit extends Cubit<AllProjectState> {
  AllProjectsCubit() : super(AllProjectInitial());

  static AllProjectsCubit get(context) => BlocProvider.of(context);

  Future<void> getAllProjects({required String departmentSelect}) async {
    try {
      print("🔄 بدأ تحميل البيانات...");
      emit(AllProjectLoading());

      Either<String, ProjectsModel> result = await ProjectsRepo.getInstance()
          .getAllProjects(department: departmentSelect);

      result.fold(
            (failure) {
          print("❌ فشل في جلب البيانات: $failure");
          emit(AllProjectError(message: failure));
        },
            (projectsData) {
          print("✅ تم جلب البيانات بنجاح.");
          print("📊 عدد المشاريع: ${projectsData.data?.projects?.length ?? 0}");
          emit(AllProjectSuccess(allProjectData: projectsData));
        },
      );
    } catch (e) {
      print("⚠️ حدث خطأ غير متوقع في الكيوبت: $e");
      emit(
        AllProjectError(message: "حدث خطأ غير متوقع في الكيوبت: ${e.toString()}"),
      );
    }
  }
}