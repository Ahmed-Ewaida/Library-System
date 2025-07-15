class BookRequests {
  int? bookId;
  String? type;
  String? dueDate;

  BookRequests({
    this.bookId,
    this.type,
    this.dueDate,
  });

  // إضافة toJson method للتأكد من التحويل الصحيح
  Map<String, dynamic> toJson() {
    return {
      'book_id': bookId,
      'type': type,
      'due_date': dueDate,
    };
  }
}