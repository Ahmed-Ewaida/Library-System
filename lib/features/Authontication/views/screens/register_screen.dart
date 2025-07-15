import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/Authontication/register/data/model/register_model.dart';

import '../../../../Core/widget/constant.dart';
import '../../register/manager/register_cubit/register_cubit.dart';
import '../../register/manager/register_cubit/register_state.dart';
import '../widget/Custom_textField_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "/RegisterScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // String? selectedYear; // لم تعد هناك حاجة لهذه المتغير هنا بشكل مباشر، الكيوبت هو من يديرها

  final List<String> years = ["الأولى", "الثانية", "الثالثة", "الرابعة"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                AppText.register_text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: AppText.student_name,
                        controller: RegisterCubit.get(context).nameController,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: AppText.student_code,
                        controller: RegisterCubit.get(
                          context,
                        ).universityCodeController,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: AppText.password,
                        isPassword: true,
                        controller: RegisterCubit.get(
                          context,
                        ).passwordController,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: AppText.confirm_password,
                        isPassword: true,
                        controller: RegisterCubit.get(
                          context,
                        ).ConfirmPasswordController,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: AppText.email,
                        controller: RegisterCubit.get(context).emailController,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: AppText.phone_number,
                        controller: RegisterCubit.get(context).phoneController,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: AppText.full_name,
                        controller: RegisterCubit.get(
                          context,
                        ).fullnameController,
                      ),
                      const SizedBox(height: 15),

                      Dropdown_Button(
                        dropdownItems: years,
                        textbox: AppText.student_level,
                        onChanged: (value) {
                          RegisterCubit.get(context).updateSelectedYear(value);
                        },
                        // 💡 يمكن إضافة هذا لإظهار القيمة المختارة بعد إعادة بناء الـ widget
                        selectedValue: RegisterCubit.get(context).selectedYear != null
                            ? years[RegisterCubit.get(context).selectedYear! - 1]
                            : null,
                      ),
                      const SizedBox(height: 15),
                      // 💡 إضافة حقل للقسم
                      CustomTextField(
                        label: AppText.department_name, // افترض وجود هذه القيمة في constant.dart
                        controller: RegisterCubit.get(context).departmentController,
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          var cubit = RegisterCubit.get(context);
                          print(state.toString());
                          if (state is RegisterLoading) {
                            return const Center(child: CircularProgressIndicator()); // 💡 استخدام Center و const
                          } else {
                            return Center(
                              child: SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    var user = RegisterUserModel(
                                      email: cubit.emailController.text,
                                      universityCode:
                                      cubit.universityCodeController.text,
                                      phoneNo: cubit.phoneController.text,
                                      fullname: cubit.fullnameController.text,
                                      level: cubit.selectedYear, // 💡 تم التعديل هنا: استخدام selectedYear
                                      department: cubit.departmentController.text, // 💡 استخدام controller للقسم
                                      selectedYear: cubit.selectedYear, // 💡 يمكن إزالته إذا لم يكن مطلوباً في Model
                                      password: cubit.passwordController.text,
                                      username: cubit.nameController.text,
                                      passwordConfirmation: cubit.ConfirmPasswordController.text,
                                      // 💡 تم حذف ",cubit" الزائدة هنا
                                    );
                                    cubit.register(user);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0XFF0C8CE9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    minimumSize: const Size(
                                      double.infinity,
                                      60,
                                    ),
                                  ),
                                  child: Text(
                                    AppText.register_text,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                            context.push(LoginScreen.id);
                          } else if (state is RegisterError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                      ),

                      const SizedBox(height: 10),

                      // ✅ رابط تسجيل الدخول
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppText.register_question,
                              style: const TextStyle(fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppText.login_text,
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

                      const SizedBox(height: 40), // ✅ ضمان عدم التجاوز
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}