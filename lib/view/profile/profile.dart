import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';
import '../auth_screens/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Profile',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(20),
              child: Image.asset(
                AppAssets.lawyer,
                fit: BoxFit.cover,
                height: 60,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              readonly: true,
              hintText: 'Cnic',
              isWhiteBackground: true,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              readonly: true,
              hintText: 'firstname',
              isWhiteBackground: true,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              readonly: true,
              hintText: 'lastname',
              isWhiteBackground: true,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              readonly: true,
              hintText: 'email',
              isWhiteBackground: true,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              readonly: true,
              hintText: 'description',
              isWhiteBackground: true,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              readonly: true,
              hintText: 'phone number',
              isWhiteBackground: true,
            ),
            SizedBox(
              height: 20,
            ),
            RoundedElevatedButton(
              borderRadius: 23,
              onPressed: () async {
                await locator<LocalStorageService>().clearAll();
                Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (_) => false,
                );
              },
              text: 'Logout',
            )
          ],
        ),
      ),
    );
  }
}
