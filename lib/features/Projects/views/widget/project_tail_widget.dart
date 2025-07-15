import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t1/features/Projects/data/model/projects_model.dart';
import 'package:t1/features/Books/manager/fav_manager/favorites_manager.dart';
import 'package:t1/features/Books/manager/read_manager/read_manager.dart';
import 'package:t1/features/Books/data/model/all_books_model.dart';
import '../../../Books/views/widget/custom_book_icon_widget.dart';
import '../../../Books/views/widget/custom_like_button_widget.dart';

class ProjectTail extends StatelessWidget {
  final Projects project;
  final VoidCallback onTap;

  const ProjectTail({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesManager = Provider.of<FavoritesManager>(context);
    final readManager = Provider.of<ReadManager>(context);

    final bookFromProject = Books(
      bookId: project.projectId,
      bookName: project.projectName,
      author: project.supervisor,
      image: project.image,
      department: "PROJECT_${project.department ?? ''}",
      status: project.status,
      averageRating: 0.0,
      isFavorited: false,
      reviewsCount: 0,
    );

    // ✨ التحقق باستخدام اسم المشروع ونوعه
    final isLiked = favoritesManager.isFavorite(project.projectName, "project");
    final isInReadingList = readManager.isRead(project.projectName, "project");

    final String title = project.projectName ?? 'عنوان غير متوفر';
    final String imageUrl = project.image ?? '';
    final String status = project.status ?? 'unknown';
    final Color statusColor = status == 'available' ? Colors.green.shade700 : Colors.red.shade700;
    final String statusText = status == 'available' ? 'متوفّر' : 'غير متوفّر';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xFF333333),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomLoveButton(
                          isLiked: isLiked,
                          onTap: () => favoritesManager.toggleFavorite(bookFromProject),
                        ),
                        const SizedBox(width: 4),
                        BookLikeButton(
                          isBookSelected: isInReadingList,
                          onTap: () => readManager.toggleRead(bookFromProject),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl.isNotEmpty
                          ? imageUrl
                          : "https://i.pinimg.com/564x/11/3b/09/113b09054359754c73099995209e7552.jpg",
                      width: 70,
                      height: 95,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 70,
                          height: 95,
                          color: Colors.grey[200],
                          child: const Image(
                            image: AssetImage(
                              'assets/fluent-emoji-flat_blue-book (1).png',
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}