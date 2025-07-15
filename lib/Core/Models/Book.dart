

class Book {
  final String title;
  final String author;
  final String department;
  final String location;
  final int number;
  final bool status;
  final String imageUrl;
  final double rating;
  bool isFavorite;
  bool isInReadingList;

  Book({
    required this.title,
    required this.author,
    required this.department,
    required this.location,
    required this.number,
    required this.status,
    required this.imageUrl,
    required this.rating,
    this.isFavorite = false,
    this.isInReadingList = false,
  });
}
