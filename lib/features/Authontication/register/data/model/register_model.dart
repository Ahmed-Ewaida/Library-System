class RegisterUserModel{
  String? username;
  String? fullname;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? phoneNo;
  int? level;
  String? department;
  String? universityCode;
  int? selectedYear;

  RegisterUserModel({required this.username,required this.fullname,required this.email,required this.password,required this.passwordConfirmation,required this.phoneNo,required this.level,required this.department,required this.universityCode,required this.selectedYear});
}