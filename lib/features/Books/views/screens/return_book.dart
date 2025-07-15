import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/features/Books/manager/return_book_cubit/return_book_cubit.dart';
import 'package:t1/features/Books/manager/return_book_cubit/return_book_state.dart';
import 'package:t1/features/Books/views/widget/return_book_tail_widget.dart';
import '../../../../Core/custom_appBar.dart';

class ReturnBook extends StatelessWidget {
  const ReturnBook({super.key});
  static String id = "/ReturnBook";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReturnBookCubit(),
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "اعادة كتاب",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<ReturnBookCubit, ReturnBookState>(
                builder: (context, state) {
                  if (state is ReturnBookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ReturnBookSuccess) {
                    // 🚀 الخطوة 1: فلترة القائمة
                    final allBookRequests = state.returnBookModel.data?.requestData ?? [];
                    final activeBooks = allBookRequests.where((request) {
                      // الشرط: إظهار الكتاب فقط إذا كانت حالته ليست "returned" وليست "rejected"
                      return  request.status=="approved";
                    }).toList();

                    // 🚀 الخطوة 2: التحقق إذا كانت القائمة فارغة بعد الفلترة
                    if (activeBooks.isEmpty) {
                      return const Center(
                        child: Text("لا توجد كتب لإرجاعها حاليًا."),
                      );
                    }

                    // 🚀 الخطوة 3: عرض القائمة المفلترة
                    return ListView.builder(
                      itemCount: activeBooks.length,
                      itemBuilder: (context, index) {
                        final requestData = activeBooks[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReturnBookTail(
                            requestData: requestData,
                            onTap: () {
                              // يمكنك هنا إضافة منطق التنقل إلى شاشة التفاصيل إذا أردت
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is ReturnBookError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text("ابدأ بتحميل البيانات"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}