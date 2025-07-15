import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t1/features/Books/data/model/all_books_model.dart';
import 'package:t1/local.dart';

class ReadManager extends ChangeNotifier {
  final Map<int, List<Books>> _userReadBooks = {};

  ReadManager() {
    _loadReadList();
  }

  List<Books> get readBooks {
    int? userId = LocalData.studentId;
    if (userId == null) return [];
    return List.unmodifiable(_userReadBooks[userId] ?? []);
  }

  // ✨ التحقق باستخدام اسم العنصر ونوعه
  bool isRead(String? itemName, String itemType) {
    int? userId = LocalData.studentId;
    if (itemName == null || userId == null) return false;
    if (_userReadBooks.containsKey(userId)) {
      return _userReadBooks[userId]!.any((item) {
        bool isProjectType = item.department?.startsWith("PROJECT_") ?? false;
        String currentItemType = isProjectType ? "project" : "book";

        return item.bookName == itemName && currentItemType == itemType;
      });
    }
    return false;
  }

  // ✨ التبديل باستخدام اسم العنصر ونوعه
  void toggleRead(Books book) async {
    int? userId = LocalData.studentId;
    if (userId == null) return;

    if (!_userReadBooks.containsKey(userId)) {
      _userReadBooks[userId] = [];
    }

    bool isProjectType = book.department?.startsWith("PROJECT_") ?? false;
    String itemType = isProjectType ? "project" : "book";

    final index = _userReadBooks[userId]!.indexWhere((item) {
      bool currentIsProjectType = item.department?.startsWith("PROJECT_") ?? false;
      String currentItemType = currentIsProjectType ? "project" : "book";
      return item.bookName == book.bookName && currentItemType == itemType;
    });

    if (index != -1) {
      _userReadBooks[userId]!.removeAt(index);
    } else {
      _userReadBooks[userId]!.add(book);
    }
    await _saveReadList();
    notifyListeners();
  }

  Future<void> _saveReadList() async {
    int? userId = LocalData.studentId;
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final List<String> readBooksJson = (_userReadBooks[userId] ?? [])
        .map((book) => jsonEncode(book.toJson()))
        .toList();
    await prefs.setStringList('read_list_$userId', readBooksJson);
  }

  Future<void> _loadReadList() async {
    int? userId = LocalData.studentId;
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final readBooksJson = prefs.getStringList('read_list_$userId');

    if (readBooksJson != null) {
      _userReadBooks[userId] = readBooksJson
          .map((jsonString) => Books.fromJson(jsonDecode(jsonString)))
          .toList();
    }
    notifyListeners();
  }
}