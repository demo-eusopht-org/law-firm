import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/widgets/rounded_image_view.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/users/get_notifications_response.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/loader.dart';
import '../../widgets/text_widget.dart';
import 'bloc/notification_bloc.dart';
import 'bloc/notification_events.dart';
import 'bloc/notification_states.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<NotificationBloc>(context).add(
        GetNotificationsEvent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Notification',
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NotificationBloc, NotificationState>(
      bloc: BlocProvider.of<NotificationBloc>(context),
      builder: (context, state) {
        if (state is LoadingNotificationState) {
          return const Loader();
        } else if (state is ErrorNotificationState) {
          return Center(
            child: textWidget(text: state.message),
          );
        } else if (state is SuccessNotificationState) {
          return _buildNotifications(state.notifications);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildNotifications(List<Notification> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: textWidget(
          text: 'No notifications!',
          fWeight: FontWeight.w700,
          fSize: 22,
        ),
      );
    }
    notifications.sort((notification1, notification2) {
      return notification2.createdAt.compareTo(notification1.createdAt);
    });
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        String notificationDate = notification.createdAt.getFormattedDateTime();
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          elevation: 5,
          child: ListTile(
            leading: notification.image != null
                ? RoundNetworkImageView(url: notification.image!, size: 100)
                : const Icon(
                    Icons.notifications,
                    size: 40,
                  ),
            title: textWidget(text: notification.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(text: notification.body),
                textWidget(text: notificationDate),
              ],
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
