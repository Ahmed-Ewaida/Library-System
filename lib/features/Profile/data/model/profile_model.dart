class ProfileModel {
  String? status;
  Data? data;

  ProfileModel({this.status, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? studentId;
  String? username;
  String? fullname;
  String? email;
  String? phoneNo;
  int? level;
  String? department;
  String? universityCode;
  String? image;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.studentId,
        this.username,
        this.fullname,
        this.email,
        this.phoneNo,
        this.level,
        this.department,
        this.universityCode,
        this.image,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    username = json['username'];
    fullname = json['fullname'];
    email = json['email'];
    phoneNo = json['phone_no'];
    level = json['level'];
    department = json['department'];
    universityCode = json['university_code'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['level'] = this.level;
    data['department'] = this.department;
    data['university_code'] = this.universityCode;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
