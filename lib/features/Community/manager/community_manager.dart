// lib/features/Community/manager/community_manager.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Core/Models/post.dart';
import '../../../../features/Community/data/models/comment_model.dart';
import '../../../../local.dart';

class CommunityManager extends ChangeNotifier {
  final List<PostModel> _posts = [];

  List<PostModel> get posts => List.unmodifiable(_posts);

  CommunityManager() {
    _initializePosts();
  }

  // إضافة البوستات الثابتة في البداية
  void _initializePosts() {
    _loadPosts().then((_) {
      // إضافة البوستات الثابتة فقط إذا لم تكن موجودة
      if (_posts.isEmpty) {
        _addInitialPosts();
      }
    });
  }

  void _addInitialPosts() {
    final staticPosts = [
      PostModel(
        content: "ممكن ترشحولى كتاب كويس لdataStructure",
        author: "بسمة حسام",
        id: "static_post_1",
        timestamp: DateTime.now().subtract(Duration(days: 7)),
      ),
      PostModel(
        content: "ايه أفضل الكتب اللى قرأتوها فى أساسيات البرمجه عموما",
        author: "ايمان رضا",
        id: "static_post_2",
        timestamp: DateTime.now().subtract(Duration(days: 5)),
        comments: [
          CommentModel(
              author: "يوسف مصطفى",
              content: "object oriented programming"
          ),

        ],
      ),
      PostModel(
        content: "ممكن حد يساعدنى فى اختيار القسم ؟",
        author: "ريم أكمل",
        id: "static_post_3",
        timestamp: DateTime.now().subtract(Duration(days: 3)),
        comments: [
          CommentModel(
              author: "عمر خالد",
              content: "ايه المواد اللى انتى كنتى حابه تذاكريها فى اولى وتانيه ؟"
          ),
        ],
      ),
      PostModel(
        content: "ازاى بدأتوا تقرأوا كتب فى البرمجه وازاى اخد الاستفاده الكامله من الكتاب؟",
        author: "فاطمة أحمد",
        id: "static_post_4",
        timestamp: DateTime.now().subtract(Duration(days: 2)),
      ),
      PostModel(
        content: "بتعملوا ايه لو معندكوش القدرة على قراءة كتاب للاخر او بتملوا علششان فرق اللغه؟",
        author: "اميرة حسين",
        id: "static_post_5",
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        comments: [
          CommentModel(
              author: "خالد أحمد",
              content: "مبنقرأش الكتاب كامل على بعضه بنقرأ جزئيه جزئيه وبنحاول نطبقها فممكن نقعد فى الكتاب شهرين عادى"
          ),

          CommentModel(
              author: "علي حسن",
              content: "بحاول اكون سامعه فيديوهات عن التوبيك قبل ما اقرأ عنه "
          ),
        ],
      ),
    ];

    _posts.addAll(staticPosts);
    _savePosts();
    notifyListeners();
  }

  void addPost(String content) {
    final newPost = PostModel(
      content: content,
      author: LocalData.studentName ?? "مستخدم غير معروف",
      timestamp: DateTime.now(),
    );
    _posts.insert(0, newPost); // إضافة المنشور الجديد في المقدمة
    _savePosts();
    notifyListeners();
  }

  void addComment({required String postId, required String commentContent}) {
    final postIndex = _posts.indexWhere((post) => post.id == postId);

    if (postIndex != -1) {
      final newComment = CommentModel(
        author: LocalData.studentName ?? "مستخدم غير معروف",
        content: commentContent,
      );
      _posts[postIndex].comments.add(newComment);
      _savePosts();
      notifyListeners();
    } else {
      print("Post with ID $postId not found!");
    }
  }

  // حفظ المنشورات في SharedPreferences
  Future<void> _savePosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> postsJson = _posts.map((post) => json.encode(post.toJson())).toList();
      await prefs.setStringList('community_posts', postsJson);
    } catch (e) {
      print("Error saving posts: $e");
    }
  }

  // تحميل المنشورات من SharedPreferences
  Future<void> _loadPosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final postsJson = prefs.getStringList('community_posts');
      if (postsJson != null) {
        _posts.clear();
        _posts.addAll(postsJson.map((jsonString) => PostModel.fromJson(json.decode(jsonString))).toList());
      }
    } catch (e) {
      print("Error loading posts: $e");
    }
    notifyListeners();
  }

  // دالة للحصول على منشور محدد بواسطة ID
  PostModel? getPostById(String postId) {
    try {
      return _posts.firstWhere((post) => post.id == postId);
    } catch (e) {
      return null;
    }
  }

  // دالة لمسح جميع المنشورات (للاختبار)
  void clearAllPosts() {
    _posts.clear();
    _savePosts();
    notifyListeners();
  }

  // دالة لإعادة تحميل البوستات الثابتة
  void resetToStaticPosts() {
    _posts.clear();
    _addInitialPosts();
  }
}