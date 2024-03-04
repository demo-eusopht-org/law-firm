import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class RolePermission extends StatefulWidget {
  const RolePermission({Key? key}) : super(key: key);

  @override
  State<RolePermission> createState() => _RolePermissionState();
}

class _RolePermissionState extends State<RolePermission> {
  bool _switchValue = false;
  bool _switchValue2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Roles and Permission',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            buildExpansionTile(
              'Admin',
              'Create Lawyer',
              'Sign In',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpansionTile(String title, String label1, String label2) {
    return Theme(
      data: ThemeData(
        hintColor: Colors.red,
        dividerColor: Colors.green,
      ),
      child: ExpansionTile(
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        collapsedBackgroundColor: Colors.green,
        iconColor: Colors.green,
        title: textWidget(
          text: title,
          fSize: 18.0,
          fWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        children: [
          ListTile(
            title: textWidget(
              text: label1,
              fSize: 16.0,
              color: Colors.black87,
            ),
            trailing: Switch.adaptive(
              activeTrackColor: Colors.green[200],
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.white,
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
          ),
          ListTile(
            title: textWidget(
              text: label2,
              fSize: 16.0,
              color: Colors.black87,
            ),
            trailing: Switch.adaptive(
              activeTrackColor: Colors.green[200],
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.white,
              value: _switchValue2,
              onChanged: (value) {
                setState(() {
                  _switchValue2 = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
