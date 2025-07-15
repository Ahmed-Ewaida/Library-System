
// lib/features/Notifications/manager/cubit/notification_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/features/Books/manager/book_status_cubit/book_status_state.dart';

import '../../data/repo/book_status_repo.dart';

class BookStatusCubit extends Cubit<BookStatusState> {
  BookStatusCubit() : super(BookStatusInitial());

  final BookstatusRepo _repo = BookstatusRepo.getInstance();

  Future<void> getBookstatus({required int bookId}

      ) async {
    emit(( BookStatusLoading()));
    var result = await _repo.getBookstatus(
      bookId: bookId,
    );
    result.fold(
          (failure) => emit(BookStatusError(message: failure)),
          (bookStatusModel) =>
          emit(BookStatusSuccess( bookStatusModel: bookStatusModel)),
    );
  }
}