// lib/features/Notifications/manager/cubit/notification_state.dart

import 'package:t1/features/Notifications/data/model/notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final NotificationModel notificationModel;
  NotificationSuccess({required this.notificationModel});
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError({required this.message});
}