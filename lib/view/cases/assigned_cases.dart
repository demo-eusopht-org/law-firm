import 'package:case_management/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class AssignedCases extends StatefulWidget {
  const AssignedCases({super.key});

  @override
  State<AssignedCases> createState() => _AssignedCasesState();
}

class _AssignedCasesState extends State<AssignedCases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: false,
        title: 'My Assigned Cases',
      ),
    );
  }
}
