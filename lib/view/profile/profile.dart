import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';

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
        showBackArrow: false,
        title: 'Profile',
        leadingWidth: 0.0,
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
              hintText: 'Name',
              isWhiteBackground: true,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Cnic',
              isWhiteBackground: true,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Email',
              isWhiteBackground: true,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
