class LoginRespons {
  String? status;
  String? message;
  Data? data;

  LoginRespons({this.status, this.message, this.data});

  LoginRespons.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  Student? student;

  Data({this.token, this.student});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    student =
    json['student'] != null ? new Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
    return data;
  }
}

class Student {
  int? studentId;
  String? username;
  String? fullname;
  int? level;
  String? department;
  String? universityCode;
  String? image;

  Student(
      {this.studentId,
        this.username,
        this.fullname,
        this.level,
        this.department,
        this.universityCode,
        this.image});

  Student.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    username = json['username'];
    fullname = json['fullname'];
    level = json['level'];
    department = json['department'];
    universityCode = json['university_code'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['level'] = this.level;
    data['department'] = this.department;
    data['university_code'] = this.universityCode;
    data['image'] = this.image;
    return data;
  }
}
