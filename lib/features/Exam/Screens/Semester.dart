import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../Core/Back_Arrow.dart';
import '../../../Core/custom_appBar.dart';
import '../../../viewmodels/Exam_viewmodels.dart';
import '../Widget/CustomOptionTile.dart';
import 'Department.dart';

class Semester extends StatelessWidget {
  final String yearId;
  static String id = '/Semester';
 const Semester({super.key,required  this.yearId,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(),
          const BackArrow(),
          Expanded(
            child: ListView.builder(
                itemCount: semesterNum.Semesters.length,
                itemBuilder: (context, index) {
                  final semester = semesterNum.Semesters[index];
                  return CustomOptionTile(
                      text: semester.name,
                      onTap: () {
                        context.push(
                          Departments.id,
                          extra: {
                            'yearId': yearId,
                            'semesterId': semester.id,
                            'departments': Departments.id
                          },
                        );
                      }
                  );
                }),
          ),
        ],
      ),
    );
  }
}

final semesterNum = SemesterViewModel();