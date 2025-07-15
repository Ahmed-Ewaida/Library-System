abstract class ReturnActionState {}

class ReturnActionInitial extends ReturnActionState {}

class ReturnActionLoading extends ReturnActionState {}

class ReturnActionSuccess extends ReturnActionState {
  final String message;
  ReturnActionSuccess({required this.message});
}

class ReturnActionError extends ReturnActionState {
  final String message;
  ReturnActionError({required this.message});
}