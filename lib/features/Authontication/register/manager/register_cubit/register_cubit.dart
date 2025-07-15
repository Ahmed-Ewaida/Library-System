import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/features/Authontication/register/manager/register_cubit/register_state.dart';

import '../../data/model/register_model.dart';
import '../../data/repo/register_repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController universityCodeController = TextEditingController();
  TextEditingController levelController = TextEditingController(); // 💡 قد لا تحتاج إليه إذا كنت تستخدم selectedYear للمستوى
  TextEditingController departmentController = TextEditingController();
  int? selectedYear; // 💡 هذا هو الذي سيمثل المستوى (level)

  void updateSelectedYear(String? year) {
    // Map Arabic year strings to integer values
    switch (year) {
      case "الأولى":
        selectedYear = 1;
        break;
      case "الثانية":
        selectedYear = 2;
        break;
      case "الثالثة":
        selectedYear = 3;
        break;
      case "الرابعة":
        selectedYear = 4;
        break;
      default:
        selectedYear = null;
    }
  }

  AuthRepo authRepo = AuthRepo.getinstance();

  void register(RegisterUserModel u) async {
    emit(RegisterLoading());
    var response =await authRepo.register(
      passwordConfirmation: ConfirmPasswordController.text,
      universityCode: universityCodeController.text,
      level: selectedYear ?? 0, // ✅ هذا سيتم إرساله كـ level
      department: departmentController.text,
      email: emailController.text,
      phone: phoneController.text,
      fullname: fullnameController.text,
      username: nameController.text,
      password: passwordController.text,
      selectedYear: selectedYear, // ✅ هذا لن يتم إرساله للباك إند الآن
    );
    response.fold(
          (l) {
        emit(RegisterError(message: l));
      },
          (r) {
        emit(RegisterSuccess(message: r));
      },
    );
  }
}