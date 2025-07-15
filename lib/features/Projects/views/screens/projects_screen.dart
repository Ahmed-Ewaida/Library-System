import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:t1/features/Projects/data/model/projects_model.dart';

import '../../../../Core/Data/progect_data.dart';
import '../../../../Core/Models/project_model.dart';
// import '../../../../Core/custom_appBar.dart';
import '../../../../Core/custom_appBar.dart';
// يحتوي على booksMap اللي هو مشاريع
import '../../manager/cubit/progect_cubit.dart';
import '../../manager/cubit/progect_state.dart';
import '../widget/project_tail_widget.dart'; // ويجت المشروع

import 'project_detail_screen.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key, this.departmentId, });
  static String id = "/ProjectsScreen";
 final String? departmentId;
  @override
  Widget build(BuildContext context) {
    final String selectedDepartment = departmentId ??
        (GoRouterState.of(context).extra as String? ?? 'CS');
    return BlocProvider<AllProjectsCubit>(
      create: (context) => AllProjectsCubit()..getAllProjects(departmentSelect: selectedDepartment ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  "المشاريع ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            BlocConsumer<AllProjectsCubit, AllProjectState>(
              builder: (context, state) {
                if (state is AllProjectSuccess) {
                  // الوصول إلى بيانات الكتب من الـ state
                  final ProjectsModel fetchedProjects = state.allProjectData;
                  final List<Projects>? items = fetchedProjects.data?.projects;

                  if (items == null || items.isEmpty) {
                    return const Center(child: Text("لا توجد كتب متاحة"));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final Projects? project = items[index];
                        if (project == null) {
                          return const SizedBox.shrink(); // Skip if null
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProjectTail(
                            project: project,

                            onTap: () {
                              context.push(ProjectDetails.id, extra: project.projectId);
                            },
                          ),
                        );
                      },
                    ),
                  ) ;
                } else if (state is AllProjectLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AllProjectError) {
                  return Center(
                    child: Text("فشل في تحميل المنتجات: ${state.message}"),
                  );
                }
                return const Center(
                  child: Text("جاري تحميل الكتب..."),
                ); // حالة أولية أو غير متوقعة
              },
              listener: (context, state) {
                if (state is AllProjectError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
