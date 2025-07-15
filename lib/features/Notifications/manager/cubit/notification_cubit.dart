// lib/features/Notifications/manager/cubit/notification_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/features/Notifications/data/repo/notification_repo.dart';
import 'package:t1/features/Notifications/manager/cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial()) {
    getNotifications();
  }

  final NotificationRepo _repo = NotificationRepo.getInstance();

  Future<void> getNotifications() async {
    emit(NotificationLoading());
    var result = await _repo.getNotifications();
    result.fold(
          (failure) => emit(NotificationError(message: failure)),
          (notificationModel) =>
          emit(NotificationSuccess(notificationModel: notificationModel)),
    );
  }
}