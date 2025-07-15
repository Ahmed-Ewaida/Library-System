import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t1/features/Books/data/model/all_books_model.dart';
import 'package:t1/local.dart';

class FavoritesManager extends ChangeNotifier {
  final Map<int, List<Books>> _userFavoriteBooks = {};
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  FavoritesManager() {
    _loadFavorites();
  }

  List<Books> get favoriteBooks {
    int? userId = LocalData.studentId;
    if (userId == null) {
      return [];
    }
    return List.unmodifiable(_userFavoriteBooks[userId] ?? []);
  }

  // ✨ التحقق باستخدام اسم العنصر ونوعه
  bool isFavorite(String? itemName, String itemType) {
    int? userId = LocalData.studentId;
    if (itemName == null || userId == null) return false;

    if (_userFavoriteBooks.containsKey(userId)) {
      return _userFavoriteBooks[userId]!.any((item) {
        bool isProjectType = item.department?.startsWith("PROJECT_") ?? false;
        String currentItemType = isProjectType ? "project" : "book";

        return item.bookName == itemName && currentItemType == itemType;
      });
    }
    return false;
  }

  // ✨ التبديل باستخدام اسم العنصر ونوعه
  void toggleFavorite(Books book) async {
    int? userId = LocalData.studentId;
    if (userId == null) return;

    if (!_userFavoriteBooks.containsKey(userId)) {
      _userFavoriteBooks[userId] = [];
    }

    bool isProjectType = book.department?.startsWith("PROJECT_") ?? false;
    String itemType = isProjectType ? "project" : "book";

    final index = _userFavoriteBooks[userId]!.indexWhere((item) {
      bool currentIsProjectType = item.department?.startsWith("PROJECT_") ?? false;
      String currentItemType = currentIsProjectType ? "project" : "book";
      return item.bookName == book.bookName && currentItemType == itemType;
    });

    if (index != -1) {
      _userFavoriteBooks[userId]!.removeAt(index);
    } else {
      _userFavoriteBooks[userId]!.add(book);
    }

    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    int? userId = LocalData.studentId;
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteBooksJson = (_userFavoriteBooks[userId] ?? [])
        .map((book) => jsonEncode(book.toJson()))
        .toList();
    await prefs.setStringList('favorites_$userId', favoriteBooksJson);
  }

  Future<void> _loadFavorites() async {
    _isLoading = true;
    int? userId = LocalData.studentId;
    if (userId == null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final favoriteBooksJson = prefs.getStringList('favorites_$userId');

    if (favoriteBooksJson != null) {
      _userFavoriteBooks[userId] = favoriteBooksJson
          .map((jsonString) => Books.fromJson(jsonDecode(jsonString)))
          .toList();
    }

    _isLoading = false;
    notifyListeners();
  }
}