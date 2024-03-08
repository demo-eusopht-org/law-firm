import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/listview.dart';
import 'package:flutter/material.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  height: size.height * 0.7,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 5,
                    right: 5,
                    top: 10,
                    bottom: 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffdae3e3),
                  ),
                  height: size.height * 0.68,
                  child: CustomGridView(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
