import 'package:case_management/view/auth_screens/login_screen.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(
        seconds: 5,
      ),
      () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          textWidget(
            text: 'Welcome',
            fSize: 30.0,
            color: Colors.white,
            fWeight: FontWeight.w700,
          ),
          Container(),
        ],
      ),
      // body: Stack(
      //   alignment: Alignment.center,
      //   children: [
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         CircleAvatar(
      //           radius: 60,
      //         ),
      //         textWidget(
      //           text: 'Welcome',
      //           fSize: 30.0,
      //           color: Colors.black,
      //           fWeight: FontWeight.w700,
      //         ),
      //       ],
      //     ),
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Image.asset(
      //         'assets/images/vector.png',
      //         height: Get.height * 0.7,
      //         width: Get.width,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
