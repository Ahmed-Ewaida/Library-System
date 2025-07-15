
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/login_model.dart';
import '../../data/repo/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  TextEditingController LoginNameController = TextEditingController();
  TextEditingController LoginPasswordController = TextEditingController();
  TextEditingController LoginEmailController = TextEditingController();
  LoginRepo repo = LoginRepo.getinstance();

  void login({required UserModel u})async{
    emit(LoginLoading());
    var response = await repo.login( name: LoginNameController.text, password: LoginPasswordController.text, email:LoginEmailController.text );
    response.fold((l) {
      emit(LoginError(message: l));
    }, (r) {
      emit(LoginSuccess());
    });
  }

}