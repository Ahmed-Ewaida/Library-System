import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/Authontication/views/screens/register_screen.dart';

import '../../../../Core/widget/constant.dart';
import '../../../../Core/widget/main_screen.dart';
import '../../login/data/model/login_model.dart';
import '../../login/manager/login_cubit/login_cubit.dart';
import '../../login/manager/login_cubit/login_state.dart';
import '../widget/Custom_textField_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String id = "/LoginScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),

      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                AppText.login_text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.black),
                // تغيير الأيقونة
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: AppText.student_name,
                    controller: LoginCubit.get(context).LoginNameController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    label: AppText.email,
                    controller: LoginCubit.get(context).LoginEmailController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    label: AppText.password,
                    isPassword: true,
                    controller: LoginCubit.get(context).LoginPasswordController,
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<LoginCubit, LoginState>(
                    builder: (context, state) {
                      var cubit = LoginCubit.get(context);
                      print(state.toString());
                      if (state is LoginLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Center(
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                var user = UserModel(
                                  email: cubit.LoginEmailController.text,
                                  name: cubit.LoginNameController.text,
                                  password: cubit.LoginPasswordController.text,
                                );
                                cubit.login(u: user);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0XFF0C8CE9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                minimumSize: const Size(double.infinity, 60),
                              ),
                              child: Text(
                                AppText.login_text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    listener: (context, state) {
                      final cubit = LoginCubit.get(context);
                      if (state is LoginSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end, // محاذاة الأيقونة والنص لليمين
                              children: [
                                Text(
                                  // نص الرسالة بالعربية
                                  "تم التسجيل بنجاح!",
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                ), // أيقونة الصح
                              ],
                            ),
                            backgroundColor: Colors.blue,
                            duration: const Duration(seconds: 3),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.all(10),
                          ),
                        );
                        context.push(MainScreen.id)
                          // duration: Duration(seconds: 3),
                        ;
                      } else if (state is LoginError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error ${state.message}")),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),

                  // ✅ الجملة تحت الزر مع التنقل إلى صفحة تسجيل الدخول
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppText.login_question,
                          style: const TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            // تنفيذ عند الضغط على تسجيل الدخول
                            context.push(RegisterScreen.id);
                          },
                          child: Text(
                            AppText.register_text,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0XFF0C8CE9),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
