import 'package:case_management/services/locator.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/listview.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../services/local_storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      // backgroundColor: Colors.green.shade300,
      appBar: customAppBar(
        context: context,
        showBackArrow: false,
        title: 'Dashboard',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            width: double.infinity,
            color: Colors.green,
            child: textWidget(
              text:
                  'Welcome, ${locator<LocalStorageService>().getData('name') ?? ''}',
              color: Colors.white,
              fWeight: FontWeight.w800,
              fSize: 22.0,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 5,
                right: 5,
                top: 10,
                bottom: 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffdae3e3),
              ),
              height: size.height * 0.68,
              child: const CustomGridView(),
            ),
          )
        ],
      ),
    );
  }
}
