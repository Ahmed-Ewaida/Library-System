import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:t1/features/Books/data/model/all_books_model.dart';
import '../../../API models/search_model.dart';
import '../../../API services/search_service.dart';
import '../../../Core/custom_appBar.dart';
import '../../Books/views/screens/book_details_screen.dart';
import '../Widget/BookCardWidget.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  static String id = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<Search> {
  String searchQuery = '';
  String selectedDepartment = 'الكل';
  TextEditingController searchController = TextEditingController();
  List<SearchModels> AllBooks = [];
  List<SearchModels> books = [];
  // late Books book;

  final List<String> departments = ['الكل', 'is', ' IT', 'CS', 'DS'];

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  Future<void> getBooks() async {
    AllBooks = await SearchService().getSearchResult();
    print("الكتب اللي رجعت: ${AllBooks.length}");

    setState(() {
      books = AllBooks;
    });
  }

  void applyFilters() {
    final query = searchQuery.toLowerCase();

    books = AllBooks.where((book) {
      final matchesSearch =
          book.bookName?.toLowerCase().contains(query) ?? false;
      final matchesDepartment =
          selectedDepartment == 'الكل' || book.department == selectedDepartment;
      return matchesSearch && matchesDepartment;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchQuery = value;
                applyFilters();
              },
              decoration: InputDecoration(
                hintText: 'بحث عن اسم الكتاب...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: Row(
              children: [
                const Text('القسم:'),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedDepartment,
                    items: departments.map((String department) {
                      return DropdownMenuItem<String>(
                        value: department,
                        child: Text(department),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedDepartment = newValue!;
                        applyFilters();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: books.isEmpty
                ? const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            )
                : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return GestureDetector(
                  onTap: () {
                    final bookData = Books(
                      bookId: book.bookId,
                      author: book.author,
                      image: book.image,
                      reviewsCount: book.reviewsCount,
                      bookName: book.bookName,
                      status: book.status,
                      isFavorited: book.isFavorited,
                      averageRating: book.averageRating,
                      department: book.department,
                    );
                    context.push(BookDetailsScreen.id, extra: bookData);
                  },
                  child: BookCardWidget(

                    bookName: book.bookName ?? '',
                    status: (book.status?.toLowerCase() == 'available') ? 'متوفر' : 'غير متوفر',
                    isFavorited: book.isFavorited ?? false,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
