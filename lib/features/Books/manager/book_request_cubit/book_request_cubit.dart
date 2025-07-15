import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:testt/features/Books/data/model/book_request_response_model.dart';
import 'package:t1/features/Books/data/model/book_requests_model.dart';
import 'package:t1/features/Books/data/repo/book_request_repo.dart';
import 'package:t1/features/Books/manager/book_request_cubit/book_request_state.dart';

import '../../data/model/book_requests_response.dart';

class BookRequestCubit extends Cubit<BookRequestState> {
  BookRequestCubit() : super(BookRequestInitial());

  static BookRequestCubit get(context) => BlocProvider.of(context);

  final BookRequestRepo _bookRequestRepo = BookRequestRepo.getInstance();

  Future<void> requestBook({
    required int bookId,
    required String type,
    required String dueDate,
  }) async {
    emit(BookRequestLoading());
    try {
      final BookRequests requestPayload = BookRequests(
        bookId: bookId,
        type: type,
        dueDate: dueDate,
      );

      Either<String, BookRequestResponseModel> result =
      await _bookRequestRepo.createBookRequest(requestPayload);

      result.fold(
            (failure) {
          emit(BookRequestError(message: failure));
        },
            (responseModel) {
          if (responseModel.status == 'success') {
            emit(BookRequestSuccess(message: responseModel.message ?? 'تم إرسال طلب الكتاب بنجاح.'));
          } else {
            emit(BookRequestError(message: responseModel.message ?? 'فشل في إرسال طلب الكتاب.'));
          }
        },
      );
    } catch (e) {
      emit(BookRequestError(message: 'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }
}