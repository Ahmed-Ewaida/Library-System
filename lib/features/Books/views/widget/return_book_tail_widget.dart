import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/Core/widget/custom_snackbar.dart';
import 'package:t1/features/Books/data/model/return_book_model.dart';
import 'package:t1/features/Books/manager/return_action_cubit/return_action_cubit.dart';
import 'package:t1/features/Books/manager/return_action_cubit/return_action_state.dart';
import 'package:t1/features/Books/views/widget/custom_book_icon_widget.dart';
import 'package:t1/features/Books/views/widget/custom_like_button_widget.dart';

class ReturnBookTail extends StatelessWidget {
  final RequestData requestData;
  final VoidCallback onTap;

  const ReturnBookTail({
    super.key,
    required this.requestData,
    required this.onTap,
  });

  Color _getBookColor(String bookName) {
    final colors = [
      Colors.blue.shade400,
      Colors.red.shade400,
      Colors.green.shade400,
      Colors.orange.shade400,
      Colors.purple.shade400,
    ];
    return colors[bookName.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final BookData? book = requestData.book;
    if (book == null) {
      return const SizedBox.shrink();
    }

    const double rating = 3.5;
    const bool isFavorite = true;
    const bool isInReadingList = false;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        // 🚀 تم زيادة قوة الظل هنا
        elevation: 8,
        // 🚀 تم تعديل لون الظل ليصبح أكثر وضوحاً
        shadowColor: Colors.black.withOpacity(0.8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- الجزء الأول (يمين): التفاصيل والأزرار ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // --- الاسم والحالة ---
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.bookName ?? 'No Title',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF333333)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          book.status??"no status",
                          style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // --- الأيقونات وزر الإعادة ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // أيقونات الإعجاب والقراءة
                        CustomLoveButton(isLiked: isFavorite, onTap: () {}),
                        const SizedBox(width: 4),
                        BookLikeButton(isBookSelected: isInReadingList, onTap: () {}),
                        const Spacer(),
                        // زر إعادة الكتاب
                        SizedBox(
                          height: 34,
                          child: BlocProvider(
                            create: (context) => ReturnActionCubit(),
                            child: BlocConsumer<ReturnActionCubit, ReturnActionState>(
                              listener: (context, state) {
                                if (state is ReturnActionSuccess) {
                                  customSnackBar(context, state.message, Colors.green, Icons.check_circle);
                                } else if (state is ReturnActionError) {
                                  customSnackBar(context, state.message, Colors.red, Icons.error);
                                }
                              },
                              builder: (context, state) {
                                if (state is ReturnActionLoading) {
                                  return const Center(child: SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2)));
                                }
                                return OutlinedButton(
                                  onPressed: () {
                                    if (requestData.requestId != null) {
                                      context.read<ReturnActionCubit>().returnBook(requestId: requestData.requestId!);
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.grey.shade400),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                  ),
                                  child: Text('إعادة الكتاب', style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold, fontSize: 12)),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // --- الجزء الثاني (يسار): الصورة والتقييم ---
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 109,
                    decoration: BoxDecoration(
                      color: _getBookColor(book.bookName ?? ''),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.import_contacts_rounded, color: Colors.white, size: 40),
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