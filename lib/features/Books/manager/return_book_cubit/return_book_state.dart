import 'package:t1/features/Books/data/model/return_book_model.dart';

abstract class ReturnBookState {}

class ReturnBookInitial extends ReturnBookState {}

class ReturnBookLoading extends ReturnBookState {}

class ReturnBookSuccess extends ReturnBookState {
  final ReturnBookModel returnBookModel;
  ReturnBookSuccess({required this.returnBookModel});
}

class ReturnBookError extends ReturnBookState {
  final String message;
  ReturnBookError({required this.message});
}