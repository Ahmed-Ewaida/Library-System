import 'dart:convert';

class BooksModel {
  String? status;
  Data? data;

  BooksModel({this.status, this.data});

  // Factory constructor يتعامل مع كلا الهيكلين
  BooksModel.fromJson(Map<String, dynamic> json) {
    // إذا كان JSON يحتوي على 'status' و 'data' (الهيكل المتوقع)
    if (json.containsKey('status') && json.containsKey('data')) {
      status = json['status'];
      data = json['data'] != null ? Data.fromJson(json['data']) : null;
    }
    // إذا كان JSON يحتوي على 'books' مباشرة (هيكل الـ API الحالي)
    else if (json.containsKey('books')) {
      status = 'success'; // نفترض النجاح إذا وجدت البيانات
      data = Data.fromJson(json); // نمرر الـ JSON كاملاً
    }
    // حالة افتراضية
    else {
      status = json['status'] ?? 'unknown';
      data = json['data'] != null ? Data.fromJson(json['data']) : null;
    }
  }

  // Helper method to check if request was successful
  bool get isSuccess => status != null && status == 'success';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Books>? books;
  Pagination? pagination;

  Data({this.books, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(Books.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Books {
  int? bookId;
  String? bookName;
  String? author;
  String? department;
  String? status;
  String? image;
  bool? isFavorited;
  double? averageRating;
  int? reviewsCount;

  Books({
    this.bookId,
    this.bookName,
    this.author,
    this.department,
    this.status,
    this.image,
    this.isFavorited,
    this.averageRating,
    this.reviewsCount,
  });

  Books.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    bookName = json['book_name'];
    author = json['author'];
    department = json['department'];
    status = json['status'];
    image = json['image'];
    isFavorited = json['is_favorited'];
    averageRating = (json['average_rating'] is String)
        ? double.tryParse(json['average_rating']) ?? 0.0
        : (json['average_rating'] is int || json['average_rating'] is double)
        ? json['average_rating'].toDouble()
        : 0.0;
    reviewsCount = (json['reviews_count'] is String)
        ? int.tryParse(json['reviews_count']) ?? 0
        : (json['reviews_count'] is int)
        ? json['reviews_count']
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['book_id'] = bookId;
    data['book_name'] = bookName;
    data['author'] = author;
    data['department'] = department;
    data['status'] = status;
    data['image'] = image;
    data['is_favorited'] = isFavorited;
    data['average_rating'] = averageRating;
    data['reviews_count'] = reviewsCount;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalItems;
  int? perPage;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.perPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = (json['current_page'] is String)
        ? int.tryParse(json['current_page']) ?? 0
        : (json['current_page'] is int)
        ? json['current_page']
        : 0;
    totalPages = (json['total_pages'] is String)
        ? int.tryParse(json['total_pages']) ?? 0
        : (json['total_pages'] is int)
        ? json['total_pages']
        : 0;
    totalItems = (json['total_items'] is String)
        ? int.tryParse(json['total_items']) ?? 0
        : (json['total_items'] is int)
        ? json['total_items']
        : 0;
    perPage = (json['per_page'] is String)
        ? int.tryParse(json['per_page']) ?? 0
        : (json['per_page'] is int)
        ? json['per_page']
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['total_items'] = totalItems;
    data['per_page'] = perPage;
    return data;
  }
}
