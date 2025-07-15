import '../../../data/model/all_books_model.dart'; // Keep this import, as the file name hasn't changed yet
// import '../../data/model/books_model.dart'; // If you renamed the file, use this

abstract class AllBooksState {}

class AllBooksInitial extends AllBooksState {}

class AllBooksLoading extends AllBooksState {}

class AllBooksError extends AllBooksState {
  String message;
  AllBooksError({required this.message});
}

class AllBooksSuccess extends AllBooksState {
  // Change the type to the new books model
  final BooksModel allBooksData; // Use 'BooksModel' class here
  AllBooksSuccess({required this.allBooksData});
}
