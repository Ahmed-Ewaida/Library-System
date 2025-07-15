// lib/Core/Models/post.dart
import '../../features/Community/data/models/comment_model.dart';

class PostModel {
  final String id;
  final String author;
  final String content;
  final DateTime timestamp;
  final List<CommentModel> comments;

  PostModel({
    required this.content,
    required this.author,
    String? id,
    DateTime? timestamp,
    List<CommentModel>? comments,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp = timestamp ?? DateTime.now(),
        comments = comments ?? [];

  // إضافة دالة toJson للتحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  // إضافة دالة fromJson للتحويل من JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      author: json['author'] ?? '',
      content: json['content'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['timestamp'])
          : DateTime.now(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((commentJson) => CommentModel.fromJson(commentJson))
          .toList() ?? [],
    );
  }
}