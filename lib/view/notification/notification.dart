import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Notification',
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          String notificationDate = DateFormat.yMMMMd().format(DateTime.now());
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            elevation: 5,
            child: ListTile(
              leading: Icon(
                Icons.notifications,
              ),
              title: textWidget(text: 'Notification Title $index'),
              subtitle: textWidget(text: notificationDate),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
