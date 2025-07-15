
import '../../data/model/book_status_model.dart';

abstract class BookStatusState {}

class BookStatusInitial extends BookStatusState {}
class BookStatusLoading extends BookStatusState {}
class BookStatusSuccess extends BookStatusState {
  final BookStatusModel bookStatusModel;
  BookStatusSuccess({required this.bookStatusModel});
}
class BookStatusError extends BookStatusState {
  final String message;
  BookStatusError({required this.message});
}