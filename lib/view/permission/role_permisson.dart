import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/appbar_widget.dart';
import '../../widgets/text_widget.dart';
import 'create_permission_screen.dart';
import 'permission_bloc/permission_bloc.dart';
import 'permission_bloc/permission_events.dart';

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
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: Container(
        width: size.width * 0.5,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: Colors.green,
          child: textWidget(
            text: 'Create a Permission',
            color: Colors.white,
            fSize: 16.0,
            fWeight: FontWeight.w700,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const CreatePermissionScreen(),
              ),
            );
            BlocProvider.of<PermissionBloc>(context).add(
              GetRoleEvent(),
            );
          },
        ),
      ),
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
