import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:t1/Core/Back_Arrow.dart';
import 'package:t1/features/Exam/Screens/ExamView.dart';
import '../../../API models/exam_model.dart';
import '../../../API services/exam_service.dart';
import '../../../Core/custom_appBar.dart';
import '../Widget/Exam_Card.dart';

class ExamListview extends StatefulWidget {
  final Map<String, dynamic>? data;
  const ExamListview({super.key, required this.data});
  static String id = "/ExamListview";

  @override
  State<ExamListview> createState() => _ExamListviewState();
}

class _ExamListviewState extends State<ExamListview> {
  List<Exam_Model> data = [];
  List<Exam_Model> filteredExams = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print("📥 البيانات المستلمة في ExamListview: ${widget.data}");
    getdata();
  }

  Future<void> getdata() async {
    data = await Exam_Service().getExams();
    showExam();
    setState(() {
      isLoading = false;
    });
  }

  void showExam() {
    print("الفلترة على: yearId=${widget.data?['yearId']}, semesterId=${widget.data?['semesterId']}, department=${widget.data?['departmentSelect']}");
    filteredExams = data.where((exam) =>
    exam.level == widget.data?['yearId'].toString() &&
        exam.semester == widget.data?['semesterId'].toString() &&
        exam.department == widget.data?['departmentSelect'].toString()
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [BackArrow()],
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredExams.isEmpty
                ? const Center(child: Text("لا يوجد امتحانات"))
                : ListView.builder(
              itemCount: filteredExams.length,
              itemBuilder: (context, index) {
                final exam = filteredExams[index];
                return GestureDetector(
                  onTap: () {
                    context.push(ExamView.id);
                  },
                  child: ExamCard(
                    course_name: exam.courseName!,
                    department: exam.department!,
                    type: exam.type!,
                    year: exam.year!,
                    has_pdf: exam.hasPdf!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
