class BorrowModel {
  int? bookId;
  String? requestType;
  String? dueDate;

  BorrowModel({this.bookId, this.requestType, this.dueDate});

  BorrowModel.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    requestType = json['request_type'];
    dueDate = json['due_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['request_type'] = this.requestType;
    data['due_date'] = this.dueDate;
    return data;
  }
}
