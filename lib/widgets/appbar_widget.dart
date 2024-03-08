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
  // void _showPopupMenu() async {
  //   await showMenu(
  //     context: context,
  //     position: RelativeRect.fromRect(
  //       Rect.fromPoints(
  //         Offset(500, 80),
  //         Offset(100, 300),
  //       ),
  //       Offset.zero & MediaQuery.of(context).size,
  //     ),
  //     items: [
  //       PopupMenuItem(
  //         child: Text("Logout"),
  //         value: "logout",
  //       ),
  //     ],
  //   ).then(
  //     (value) async {
  //       if (value == "logout") {
  //         await locator<LocalStorageService>().clearAll();
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           CupertinoPageRoute(
  //             builder: (context) => LoginScreen(),
  //           ),
  //           (_) => false,
  //         );
  //       }
  //     },
  //   );
  // }

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
              builder: (context) => NotificationScreen(),
            ),
          );
        },
        icon: Icon(
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
  double leadingWidth = 50.0,
  Function()? onTap,
}) {
  return AppBar(
    elevation: 0,
    leading: Visibility(
      visible: showBackArrow,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            )),
      ),
    ),
    title: textWidget(
      text: title,
      color: Colors.white,
    ),
    backgroundColor: Colors.green,
    automaticallyImplyLeading: false,
    leadingWidth: leadingWidth,
    actions: action,
  );
}
