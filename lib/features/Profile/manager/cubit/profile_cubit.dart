import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/features/Profile/data/model/profile_model.dart';
import 'package:t1/features/Profile/manager/cubit/profile_state.dart';

import '../../data/repo/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  Future<void> getUserData() async {
    try {
      print("🔄 بدأ تحميل البيانات...");
      emit(ProfileLoading());

      Either<String, ProfileModel> result = await ProfileRepo.getinstance().getUserData();

      result.fold(
            (failure) {
          print("❌ فشل في جلب البيانات: $failure");
          emit(ProfileError(message: failure));
        },
            (usersData) {
          print("✅ تم جلب البيانات بنجاح.");
          emit(ProfileSuccess(profileData: usersData));
        },
      );
    } catch (e) {
      print("⚠️ حدث خطأ غير متوقع في الكيوبت: $e");
      emit(
        ProfileError(message: "حدث خطأ غير متوقع في الكيوبت: ${e.toString()}"),
      );
    }
  }
}
