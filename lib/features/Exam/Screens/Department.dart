import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../Core/Back_Arrow.dart';
import '../../../Core/custom_appBar.dart';
import '../../../viewmodels/Exam_viewmodels.dart';
import '../Widget/CustomOptionTile.dart';
import 'Exam_ListView.dart';

class Departments extends StatefulWidget {

  final Map<String, dynamic>? extraData;
  static String id = "/Department";
  const Departments({super.key, this.extraData});

  @override
  State<Departments> createState() => _DepartmentsState();
}

class _DepartmentsState extends State<Departments> {
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
                itemCount: departmentSelect.deprtment.length,
                itemBuilder: (context, index) {
                  final dep = departmentSelect.deprtment[index];
                  return CustomOptionTile(
                      text: dep.name,
                      onTap: () {
                        print("📤 Sending data: yearId=${widget.extraData?['yearId']}, semesterId=${widget.extraData?['semesterId']}, department=${dep.id}");
                        context.push(ExamListview.id, extra: {
                          'yearId': widget.extraData?['yearId'],
                          'semesterId': widget.extraData?['semesterId'],
                          'departmentSelect': dep.id,
                        });
                      }
                      );
                }),
          ),
        ],
      ),
    );
  }
}
final departmentSelect = DepartmentSelection();