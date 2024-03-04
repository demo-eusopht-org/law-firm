import 'package:case_management/permission/role_permisson.dart';
import 'package:case_management/view/home/lawyer_Screen.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/cases/cases.dart';
import '../view/cause/cause_list.dart';
import '../view/customer/customers.dart';

class CustomGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => LawyerScreen(),
                ),
              );
            }),
        _buildCard(
            label: 'Cases',
            image: 'assets/images/lawyer.png',
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => Cases(),
                ),
              );
            }),
        _buildCard(
          label: 'Cause List',
          image: 'assets/images/lawyer.png',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CauseList(),
              ),
            );
          },
        ),
        _buildCard(
          label: 'Closed Cases',
          image: 'assets/images/lawyer.png',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => Cases(),
              ),
            );
          },
        ),
        _buildCard(
          label: 'Customers',
          image: 'assets/images/lawyer.png',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => Customers(),
              ),
            );
          },
        ),
        _buildCard(
          label: 'Permission',
          image: 'assets/images/lawyer.png',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => RolePermission(),
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
          margin: EdgeInsets.all(5),
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
              SizedBox(
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
