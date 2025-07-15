import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/features/Books/data/repo/return_book_repo.dart';
import 'package:t1/features/Books/manager/return_action_cubit/return_action_state.dart';

class ReturnActionCubit extends Cubit<ReturnActionState> {
  ReturnActionCubit() : super(ReturnActionInitial());

  final ReturnBookRepo _repo = ReturnBookRepo.getInstance();

  Future<void> returnBook({required int requestId}) async {
    emit(ReturnActionLoading());
    final result = await _repo.returnBook(requestId: requestId);
    result.fold(
          (failure) => emit(ReturnActionError(message: failure)),
          (successMessage) => emit(ReturnActionSuccess(message: successMessage)),
    );
  }
}