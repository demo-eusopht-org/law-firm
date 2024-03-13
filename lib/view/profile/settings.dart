import 'package:case_management/view/profile/profile.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SettingsCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon),
        title: textWidget(text: title),
        onTap: onTap,
      ),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: false,
        title: 'Settings',
        leadingWidth: 0.0,
      ),
      body: ListView(
        children: [
          SettingsCard(
            title: 'Personal Info',
            icon: Icons.person,
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            elevation: 4,
            child: SwitchListTile(
              activeColor: Colors.green,
              title: textWidget(
                text: 'Enable Notifications',
              ),
              value: notificationEnabled,
              onChanged: (value) {
                setState(() {
                  notificationEnabled = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              _showLanguageBottomSheet(context);
            },
            child: Card(
              child: ListTile(
                title: textWidget(
                  text: 'Change Language',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                title: textWidget(text: 'English'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: textWidget(text: 'Urdu'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
