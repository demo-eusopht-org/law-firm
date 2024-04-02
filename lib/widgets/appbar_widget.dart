import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/notification/notification.dart';

AppBar customAppBar({
  required BuildContext context,
  controller,
  IconData? icon,
  required final bool showBackArrow,
  title,
  action,
  Function()? onTap,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    title: textWidget(
      text: title,
      color: Colors.white,
    ),
    backgroundColor: Colors.green,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const NotificationScreen(),
            ),
          );
        },
        icon: const Icon(
          Icons.notifications,
        ),
        color: Colors.white,
      ),
      // IconButton(
      //   onPressed: onTap ?? _showPopupMenu,
      //   icon: Icon(Icons.more_vert),
      //   color: Colors.white,
      // ),
    ],
  );
}

AppBar AppBarWidget({
  required BuildContext context,
  controller,
  IconData? icon,
  required final bool showBackArrow,
  title,
  action,
  double? leadingWidth = 50.0,
  Function()? onTap,
}) {
  return AppBar(
    elevation: 0,
    leading: Visibility(
      visible: showBackArrow,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
      ),
    ),
    title: textWidget(text: title, color: Colors.white, fSize: 20.0),
    backgroundColor: Colors.green,
    automaticallyImplyLeading: false,
    leadingWidth: leadingWidth,
    actions: action,
  );
}
