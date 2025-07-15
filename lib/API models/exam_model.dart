class Exam_Model {
  int? examId;
  String? type;
  String? courseName;
  String? department;
  String? semester;
  String? level;
  String? doctor;
  int? year;
  bool? hasPdf;
  String? createdAt;

  Exam_Model({this.examId,
        this.type,
        this.courseName,
        this.department,
        this.semester,
        this.level,
        this.doctor,
        this.year,
        this.hasPdf,
        this.createdAt});

  Exam_Model.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    type = json['type'];
    courseName = json['course_name'];
    department = json['department'];
    semester = json['semester'];
    level = json['level'];
    doctor = json['doctor'];
    year = json['year'];
    hasPdf = json['has_pdf'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_id'] = this.examId;
    data['type'] = this.type;
    data['course_name'] = this.courseName;
    data['department'] = this.department;
    data['semester'] = this.semester;
    data['level'] = this.level;
    data['doctor'] = this.doctor;
    data['year'] = this.year;
    data['has_pdf'] = this.hasPdf;
    data['created_at'] = this.createdAt;
    return data;
  }
}