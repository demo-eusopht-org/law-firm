import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';

class UpdateScreen extends StatefulWidget {
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        height: size.height * .63,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Image.asset(
            //   AppAssets.,
            //   height: 120.0,
            // ),
            SizedBox(height: 20.0),
            textWidget(
              text: 'Update Available',
              fSize: 24.0,
              color: Colors.white,
              fWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textWidget(
                  text: 'New version available!',
                  fSize: 15.0,
                  color: Colors.white,
                ),
                textWidget(
                  text: 'Update now for the latest features',
                  fSize: 14.0,
                  color: Colors.white,
                ),
                textWidget(
                  text: 'and improvements.',
                  fSize: 14.0,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            RoundedElevatedButton(
              text: 'Update Now',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
