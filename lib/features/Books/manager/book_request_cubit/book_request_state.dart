abstract class BookRequestState {}

class BookRequestInitial extends BookRequestState {}

class BookRequestLoading extends BookRequestState {}

class BookRequestSuccess extends BookRequestState {
  final String message;
  BookRequestSuccess({required this.message});
}

class BookRequestError extends BookRequestState {
  final String message;
  BookRequestError({required this.message});
}