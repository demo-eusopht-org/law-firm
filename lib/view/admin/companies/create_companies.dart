import 'package:case_management/view/admin/companies/create_company_page.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/appbar_widget.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        title: 'Companies',
        showBackArrow: true,
      ),
      floatingActionButton: RoundedElevatedButton(
        text: 'Create Company',
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const CreateCompanyPage(),
          ),
        ),
      ),
    );
  }
}
