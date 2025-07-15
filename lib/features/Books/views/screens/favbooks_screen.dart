import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:t1/features/Books/manager/fav_manager/favorites_manager.dart';
import 'package:t1/features/Books/views/widget/book_tile_widget.dart';
import 'package:t1/features/Projects/data/model/projects_model.dart';
import 'package:t1/features/Projects/views/screens/project_detail_screen.dart';
import 'package:t1/features/Projects/views/widget/project_tail_widget.dart';
import '../../../../Core/custom_appBar.dart';

class Favbooks extends StatelessWidget {
  const Favbooks({super.key});
  static String id = "/Favbooks";

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
                const Text(
                  "قائمة المفضلة",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 8)
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Consumer<FavoritesManager>(
              builder: (context, favoritesManager, child) {
                final favoriteItems = favoritesManager.favoriteBooks;

                if (favoriteItems.isEmpty) {
                  return const Center(
                    child: Text(
                      'قائمة المفضلة فارغة.',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: favoriteItems.length,
                  itemBuilder: (context, index) {
                    final item = favoriteItems[index];

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
                        key: ValueKey('project_${project.projectName}'),
                        project: project,
                        onTap: () {
                          context.push(ProjectDetails.id, extra: project.projectId);
                        },
                      );
                    } else {
                      return BookTile(
                        // ✨ الحل: إضافة مفتاح فريد لكل كتاب
                        key: ValueKey('book_${item.bookName}'),
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