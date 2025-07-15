// lib/features/Notifications/views/screens/notification_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/features/Notifications/manager/cubit/notification_cubit.dart';
import 'package:t1/features/Notifications/manager/cubit/notification_state.dart';
import '../../../../Core/Back_Arrow.dart';
import '../../../../Core/custom_appBar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static String id = "/NotificationScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [const BackArrow(),

                  Text(
                    'الإشعارات',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    if (state is NotificationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is NotificationSuccess) {
                      final notifications =
                          state.notificationModel.data?.data ?? [];
                      if (notifications.isEmpty) {
                        return const Center(
                          child: Text("لا توجد إشعارات لعرضها."),
                        );
                      }
                      return ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  notification.message ??
                                      'لا يوجد محتوى للرسالة.',
                                  style: const TextStyle(
                                      fontSize: 16, height: 1.5),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is NotificationError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(
                        child: Text("ابدأ بتحميل البيانات"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}