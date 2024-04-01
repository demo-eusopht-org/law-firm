import 'package:case_management/view/profile/profile.dart';
import 'package:case_management/view/profile/profile_bloc/profile_bloc.dart';
import 'package:case_management/view/profile/profile_bloc/profile_events.dart';
import 'package:case_management/view/profile/profile_bloc/profile_states.dart';
import 'package:case_management/view/profile/reset_password.dart';
import 'package:case_management/view/profile/version_history.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/lawyers/profile_response.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SettingsCard({
    super.key,
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
  final _notificationEnabledNotifier = ValueNotifier<Profile?>(null);

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<ProfileBloc>(context).state;
    if (state is GotProfileState) {
      _notificationEnabledNotifier.value = state.profile;
    }
  }

  void _onNotificationStatusChanged(Profile profile, bool status) {
    _notificationEnabledNotifier.value = profile.changeNotificationStatus(
      status,
    );
    BlocProvider.of<ProfileBloc>(context).add(
      UpdateNotificationEvent(notificationsEnabled: status),
    );
  }

  @override
  void dispose() {
    _notificationEnabledNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: false,
        title: 'Settings',
        leadingWidth: 0.0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: ListView(
        children: [
          SettingsCard(
            title: 'Personal Info',
            icon: Icons.person,
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ValueListenableBuilder(
            valueListenable: _notificationEnabledNotifier,
            builder: (context, profile, child) {
              if (profile == null) {
                return const SizedBox.shrink();
              }
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 10),
                child: SwitchListTile(
                  activeColor: Colors.green,
                  title: textWidget(
                    text: 'Enable Notifications',
                  ),
                  value: profile.notificationsEnabled,
                  onChanged: (value) => _onNotificationStatusChanged(
                    profile,
                    value,
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              _showLanguageBottomSheet(context);
            },
            child: Card(
              elevation: 4,
              child: ListTile(
                title: textWidget(
                  text: 'Change Language',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SettingsCard(
            title: 'Change Password',
            icon: Icons.password_sharp,
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ResetPassword(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          SettingsCard(
            title: 'App Version',
            icon: Icons.password_sharp,
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ViewVersionHistory(),
                ),
              );
            },
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
