import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/cases/cases_screen.dart';
import '../view/cause/cause_list.dart';
import '../view/client/clients.dart';
import '../view/lawyer/lawyer_Screen.dart';
import '../view/permission/role_permisson.dart';
import 'text_widget.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final role = locator<LocalStorageService>().getData('role') ?? 'LAWYER';
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: [
        _buildCard(
            label: 'Lawyer',
            image: 'assets/images/lawyer.png',
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const LawyerScreen(),
                ),
              );
            }),
        _buildCard(
            label: 'Cases',
            image: 'assets/images/cases.png',
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Cases(
                    showTile: true,
                  ),
                ),
              );
            }),
        _buildCard(
          label: 'Cause List',
          image: 'assets/images/causelist.png',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const CauseList(),
              ),
            );
          },
        ),
        _buildCard(
          label: 'Closed Cases',
          image: 'assets/images/agrement.png',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const Cases(
                  showTile: true,
                  showOnlyClosedCases: true,
                ),
              ),
            );
          },
        ),
        _buildCard(
          label: 'Client',
          image: 'assets/images/customer.png',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const Clients(),
              ),
            );
          },
        ),
        if (role == 'ADMIN')
          _buildCard(
            label: 'Permission',
            image: 'assets/images/permission.png',
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const RolePermission(),
                ),
              );
            },
          ),
      ],
    );
  }

  GestureDetector _buildCard({
    required String label,
    required String image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
        child: Card(
          margin: const EdgeInsets.all(5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                image,
                width: 60.0,
                height: 60.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              textWidget(
                text: label,
                fSize: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
