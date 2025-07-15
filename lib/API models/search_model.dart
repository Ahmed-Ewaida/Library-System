import '../Core/constent.dart';

class SearchModels {
  int? bookId;
  String? bookName;
  String? author;
  String? department;
  String? status;
  String? image;
  bool? isFavorited;
  double? averageRating;
  int? reviewsCount;

  SearchModels({
        this.bookId,
        this.bookName,
        this.author,
        this.department,
        this.status,
        this.image,
        this.isFavorited,
        this.averageRating,
        this.reviewsCount});

  SearchModels.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    bookName = json['book_name'];
    author = json['author'];
    department = json['department'];
    status = json['status']?? true;
    image = json['image']?? blueUses;
    isFavorited = json['is_favorited'];
    averageRating = (json['average_rating'] ?? 0).toDouble(); // مهم!
    reviewsCount = json['reviews_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
