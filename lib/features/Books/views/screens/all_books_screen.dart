import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/custom_appBar.dart';
import '../../manager/all_books_cubit/cubit/all_books_cubit.dart';
import '../../manager/all_books_cubit/cubit/all_books_state.dart';
import '../../data/model/all_books_model.dart';
import '../widget/book_tile_widget.dart';

class AllBooks extends StatefulWidget {
  const AllBooks({super.key});
  static String id = "/AllBooks";

  @override
  State<AllBooks> createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllBooksCubit>(context).getBestSelleing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "كل الكتب",
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
            child: BlocBuilder<AllBooksCubit, AllBooksState>(
              builder: (context, state) {
                if (state is AllBooksSuccess) {
                  final List<Books>? items = state.allBooksData.data?.books;


                  if (items == null || items.isEmpty) {
                    return const Center(child: Text("لا توجد كتب متاحة"));
                  }
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final Books bookItem = items[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BookTile(
                          book: bookItem,
                        ),
                      );
                    },
                  );
                } else if (state is AllBooksLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AllBooksError) {
                  return Center(
                    child: Text("فشل في تحميل الكتب: ${state.message}"),
                  );
                }
                return const Center(
                  child: Text("جاري تحميل الكتب..."),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
