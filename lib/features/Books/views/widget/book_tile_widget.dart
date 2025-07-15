import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:t1/features/Books/data/model/all_books_model.dart';
import 'package:t1/features/Books/manager/fav_manager/favorites_manager.dart';
import 'package:t1/features/Books/manager/read_manager/read_manager.dart';
import '../screens/book_details_screen.dart';
import '../screens/book_status_screen.dart';
import 'custom_book_icon_widget.dart';
import 'custom_like_button_widget.dart';

class BookTile extends StatelessWidget {
  final Books book;
  final bool isbook;

  const BookTile({super.key, required this.book, this.isbook = true});

  @override
  Widget build(BuildContext context) {
    final favoritesManager = Provider.of<FavoritesManager>(context);
    final readManager = Provider.of<ReadManager>(context);

    // ✨ التحقق باستخدام اسم الكتاب ونوعه
    final isLiked = favoritesManager.isFavorite(book.bookName, "book");
    final isInReadingList = readManager.isRead(book.bookName, "book");

    final String title = book.bookName ?? 'عنوان غير متوفر';
    final String imageUrl = book.image ?? '';
    final String status = book.status ?? 'unknown';
    final Color statusColor = status == 'available' ? Colors.green.shade700 : Colors.red.shade700;
    final String statusText = status == 'available' ? 'متوفّر' : 'غير متوفّر';

    return GestureDetector(
      onTap: () {
        if (isbook) {
          context.push(BookDetailsScreen.id, extra: book);
        }
      },
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
                        // أيقونات الإعجاب والقراءة
                        CustomLoveButton(
                          isLiked: isLiked,
                          onTap: () => favoritesManager.toggleFavorite(book),
                        ),
                        const SizedBox(width: 4),
                        BookLikeButton(
                          isBookSelected: isInReadingList,
                          onTap: () => readManager.toggleRead(book),
                        ),
                        const SizedBox(width: 15),
                        // --- زر حالة الكتاب/المشروع ---
                        SizedBox(
                          height: 34,
                          child: OutlinedButton(
                            onPressed: () =>
                                context.push(BookStatus.id, extra: book),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade400),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                            ),
                            child: Text(
                              !isbook ? 'حالة المشروع' : 'حالة الكتاب',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
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