// project_department_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/custom_appBar.dart';
import '../../../../features/Projects/views/screens/projects_screen.dart';
import '../../../../Core/widget/choise_container_widget.dart';

class ProjectDepartment extends StatelessWidget {
  static String id = "/ProjectDepartment";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                " الاقسام",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  // const SizedBox(height: 10),
                  // نظم المعلومات
                  GestureDetector(
                    onTap: () {
                      context.push(ProjectsScreen.id, extra: 'is'); // Information Systems
                    },
                    child: ChoiseContianer(name: 'نظم المعلومات', pageId: ''),
                  ),
                  const SizedBox(height: 10),
                  // علوم الحاسب
                  GestureDetector(
                    onTap: () {
                      context.push(ProjectsScreen.id, extra: 'CS'); // Computer Science
                    },
                    child: ChoiseContianer(name: 'علوم الحاسب', pageId: ''),
                  ),
                  const SizedBox(height: 20),
                  // تكنولوجيا المعلومات
                  GestureDetector(
                    onTap: () {
                      context.push(ProjectsScreen.id, extra: 'it'); // Information Technology
                    },
                    child: ChoiseContianer(name: 'تكنولوجيا المعلومات', pageId: ''),
                  ),
                  const SizedBox(height: 10),
                  // دعم القرار
                  GestureDetector(
                    onTap: () {
                      context.push(ProjectsScreen.id, extra: 'ds'); // Decision Support
                    },
                    child: ChoiseContianer(name: 'دعم القرار', pageId: ''),
                  ),
                  const SizedBox(height: 10),
                  // ذكاء اصطناعي
                  GestureDetector(
                    onTap: () {
                      context.push(ProjectsScreen.id, extra: 'ai'); // Artificial Intelligence
                    },
                    child: ChoiseContianer(name: 'ذكاء اصطناعى', pageId: ''),
                  ),
                  const SizedBox(height: 10),
                  // معلوماتية طبية
                  GestureDetector(
                    onTap: () {
                      context.push(ProjectsScreen.id, extra: 'mi'); // Medical Informatics
                    },
                    child: ChoiseContianer(name: 'معلوماتيه طبية', pageId: ''),
                  ),
                  const SizedBox(height: 10),
                  // نظم المعلومات الجغرافية
                  GestureDetector(
                    onTap: () {
                      context.push(ProjectsScreen.id, extra: 'gis'); // Geographic Information Systems
                    },
                    child: ChoiseContianer(name: 'نظم المعلومات الجغرافية', pageId: ''),
                  ),
                  const SizedBox(height: 10),
                  // الأمن السيبراني
                  GestureDetector(
                    onTap: () {
                      context.push(ProjectsScreen.id, extra: 'cyber'); // Cybersecurity
                    },
                    child: ChoiseContianer(name: 'الأمن السيبرانى', pageId: ''),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
