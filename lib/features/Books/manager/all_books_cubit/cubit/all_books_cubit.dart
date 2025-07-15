import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/all_books_model.dart';
import '../../../data/repo/all_book_repo.dart';
import 'all_books_state.dart';

class AllBooksCubit extends Cubit<AllBooksState> {
  AllBooksCubit() : super(AllBooksInitial());

  static AllBooksCubit get(context) => BlocProvider.of(context);

  Future<void> getBestSelleing() async {
    try {
      print("🔄 بدأ تحميل البيانات...");
      emit(AllBooksLoading());

      // لا يوجد تغيير هنا، HomeRepo.getinstance().bestSeller() سيعيد Either<String, BooksModel>
      Either<String, BooksModel> result = await HomeRepo.getinstance()
          .bestSeller();

      result.fold(
        (failure) {
          print("❌ فشل في جلب البيانات: $failure");
          emit(AllBooksError(message: failure));
        },
        (booksData) {
          print("✅ تم جلب البيانات بنجاح.");
          emit(AllBooksSuccess(allBooksData: booksData));
        },
      );
    } catch (e) {
      print("⚠️ حدث خطأ غير متوقع في الكيوبت: $e");
      emit(
        AllBooksError(message: "حدث خطأ غير متوقع في الكيوبت: ${e.toString()}"),
      );
    }
  }
}
