import 'package:dio/dio.dart';
import '../API models/search_model.dart';
import '../Core/constent.dart';

class SearchService {
  final Dio dio = Dio();
  Future<List<SearchModels>> getSearchResult() async {
    Response response = await dio.get('$baseURl/api/v1/books?page=1&per_page=100');

    if (response.statusCode == 200) {
      List booksJson = response.data['data']['books'];
      print("📥 عدد الكتب من ال API: ${booksJson.length}");
      return booksJson.map((item) {
        return SearchModels(
          bookId: item['book_id'],
          bookName: item['book_name'],
          author: item['author'],
          department: item['department'],
          status: item['status'],
          image: item['image'],
          isFavorited: item['is_favorited'],
          averageRating: (item['average_rating'] ?? 0).toDouble(),
          reviewsCount: item['reviews_count'],
        );
      }).toList();
    } else {
      print("❌ API error: ${response.statusCode}");
      return [];
    }
  }

//   Future getGlobalSearch()async{
//     Response response = await dio.get('$baseURl/api/v1/search?type=all');
//
//     if (response.statusCode == 200) {
//       List booksJson = response.data['data']['books'];
//       print("📥 عدد الكتب من ال API: ${booksJson.length}");
//       return booksJson.map((item) {
//         return globalSearch(
//
//         );
//       }).toList();
//     } else {
//       print("❌ API error: ${response.statusCode}");
//       return [];
//     }
//
//   }
}