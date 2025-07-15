import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:t1/features/Books/manager/read_manager/read_manager.dart';
import 'package:t1/features/Books/views/widget/book_tile_widget.dart';
import 'package:t1/features/Projects/data/model/projects_model.dart';
import 'package:t1/features/Projects/views/screens/project_detail_screen.dart';
import 'package:t1/features/Projects/views/widget/project_tail_widget.dart';
import '../../../../Core/custom_appBar.dart';

class ReadMenu extends StatelessWidget {
  const ReadMenu({super.key});
  static String id = "/ReadMenu";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "قائمة القراءه",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Consumer<ReadManager>(
              builder: (context, readManager, child) {
                final readItems = readManager.readBooks;

                if (readItems.isEmpty) {
                  return const Center(
                    child: Text(
                      'لم تقم بإضافة أي عناصر إلى قائمة القراءه بعد.',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: readItems.length,
                  itemBuilder: (context, index) {
                    final item = readItems[index];

                    bool isProjectItem = item.department != null &&
                        item.department!.startsWith("PROJECT_");

                    if (isProjectItem) {
                      final project = Projects(
                        projectId: item.bookId,
                        projectName: item.bookName,
                        department: item.department!.substring(8),
                        supervisor: item.author,
                        status: item.status,
                        image: item.image,
                      );

                      return ProjectTail(
                        // ✨ الحل: إضافة مفتاح فريد لكل مشروع
                        key: ValueKey('project_read_${project.projectName}'),
                        project: project,
                        onTap: () {
                          context.push(ProjectDetails.id, extra: project.projectId);
                        },
                      );
                    } else {
                      return BookTile(
                        // ✨ الحل: إضافة مفتاح فريد لكل كتاب
                        key: ValueKey('book_read_${item.bookName}'),
                        book: item,
                        isbook: true,
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}