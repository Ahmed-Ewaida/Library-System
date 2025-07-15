import 'package:dio/dio.dart';
import '../API models/exam_model.dart';
import '../Core/constent.dart';
class Exam_Service {
  final  Dio dio = Dio();
  Future getExams() async {
    Response response = await dio.get('$baseURl/api/v1/exams');
    try {
      if (response.statusCode == 200) {
        List<dynamic> examJSON = response.data['data']['exams'];
        print('عدد الامتحانات فى ال API = ${examJSON}');
        return examJSON.map((item) =>
            Exam_Model(
              type: item['type'],
              courseName: item['course_name'],
              department: item['department'],
              semester: item['semester'],
              level: item['level'],
              doctor: item['doctor'],
              year: item['year'],
              hasPdf: item['has_pdf'],
            )).toList();
      }
    } catch (e) {
      print('Error fetching exams: $e');
      return [];
    }
  }
}