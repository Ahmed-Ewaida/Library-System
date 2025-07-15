// lib/features/Books/models/book_status_model.dart

class BookStatusModel {
  final String status;
  final BookStatusData data;

  BookStatusModel({required this.status, required this.data});

  factory BookStatusModel.fromJson(Map<String, dynamic> json) {
    return BookStatusModel(
      status: json['status'],
      data: BookStatusData.fromJson(json['data']),
    );
  }
}

class BookStatusData {
  final int bookId;
  final String bookName;
  final String status;
  final String? expectedAvailableDate;
  final String message;

  BookStatusData({
    required this.bookId,
    required this.bookName,
    required this.status,
    required this.expectedAvailableDate,
    required this.message,
  });

  factory BookStatusData.fromJson(Map<String, dynamic> json) {
    return BookStatusData(
      bookId: json['book_id'],
      bookName: json['book_name'],
      status: json['status'],
      expectedAvailableDate: json['expected_available_date'],
      message: json['message'],
    );
  }
}