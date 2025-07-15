import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:t1/features/Books/manager/book_status_cubit/book_status_cubit.dart';
import 'package:t1/features/Books/manager/book_status_cubit/book_status_state.dart';
import '../../../../Core/custom_appBar.dart';
import '../../../../features/Borrow_Screens/Screens/Borrowing_Info.dart';
import '../../data/model/all_books_model.dart';

class BookStatus extends StatefulWidget {
  final Books book;
  const BookStatus({super.key, required this.book});
  static String id = "/BookStatus";

  @override
  State<BookStatus> createState() => _BookStatusState();
}

class _BookStatusState extends State<BookStatus> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookStatusCubit()..getBookstatus(bookId: widget.book.bookId!),
      child: Scaffold(
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
              ],
            ),
            const Text(
              'حالة الكتاب:',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<BookStatusCubit, BookStatusState>(
              builder: (context, state) {
                if (state is BookStatusLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookStatusSuccess) {
                  final bookStatus = state.bookStatusModel.data;
                  return Column(
                    children: [
                      Text(
                        'الكتاب حاليا: ${bookStatus.status}',
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'متوقع توافره:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        bookStatus.expectedAvailableDate??"اليوم",
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  );
                } else if (state is BookStatusError) {
                  return Center(
                    child: Text(
                      'حدث خطأ: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const Center(child: Text("جاري تحميل حالة الكتاب..."));
              },
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.push(BorrowRequestPage.id, extra: widget.book.bookId);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(7),
                      backgroundColor: const Color(0XFF0C8CE9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'استعارة الكتاب',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'تم تأكيد طلبك بنجاح! سنعلمك عند توفر الكتاب.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          backgroundColor: const Color(0XFF0C8CE9),
                          duration: const Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          padding: const EdgeInsets.all(15),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(7),
                      backgroundColor: const Color(0XFF0C8CE9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'أعلمنى عند توفره',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}