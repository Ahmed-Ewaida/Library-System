// lib/features/Community/data/models/comment_model.dart

class CommentModel {
  final String author;
  final String content;

  CommentModel({required this.author, required this.content});

  // إضافة دالة toJson للتحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'content': content,
    };
  }

  // إضافة دالة fromJson للتحويل من JSON
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      author: json['author'] ?? '',
      content: json['content'] ?? '',
    );
  }
}