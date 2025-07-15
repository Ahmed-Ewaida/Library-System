import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../Core/Back_Arrow.dart';
import '../../../Core/custom_appBar.dart';
import '../../../viewmodels/Exam_viewmodels.dart';
import '../Widget/CustomOptionTile.dart';
import 'Semester.dart';

class AcademicYear extends StatefulWidget {
  static String id = "/AcademicYear";
  const AcademicYear({Key? key}) : super(key: key);
  @override
  State<AcademicYear> createState() => _AcademicYearState();
}
class _AcademicYearState extends State<AcademicYear> {
  @override
  void initState() {super.initState();}
  final AcademicYears = AcademicYearViewModel();
  @override
  Widget build(BuildContext context) {
    // لصفحة الاولى
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(),
          const BackArrow(),
          Expanded(
            child: ListView.builder(
                itemCount: AcademicYears.allYears.length,
                itemBuilder: (context, index) {
                  final years = AcademicYears.allYears[index];
                  return CustomOptionTile(
                      text: years.name,
                      onTap: () {
                        print("Pressed on year ${years.id}");
                        context.push( Semester.id , extra: {
                          'yearId':years.id.toString(),
                        });
                      });
                }),
          )
        ],
      ),
    );
  }
}