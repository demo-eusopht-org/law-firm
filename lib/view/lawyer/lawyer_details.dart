import 'package:case_management/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';

class LawyerDetails extends StatefulWidget {
  const LawyerDetails({super.key});

  @override
  State<LawyerDetails> createState() => _LawyerDetailsState();
}

class _LawyerDetailsState extends State<LawyerDetails> {
  final List<Map<String, String>> personalDetails = [
    {
      'email': 'abc@gmail.com',
      'firstName': 'Waqas',
      'lastName': 'Hunain',
      'description': 'LLB,MBBS',
      'cnic': '12345-6789012-3',
    },
  ];
  final List<Map<String, String>> lawyerInfo = [
    {
      'email': 'abc@gmail.com',
      'firstName': 'Waqas',
      'lastName': 'Hunain',
      'description': 'LLB,MBBS',
      'cnic': '12345-6789012-3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Lawyer Details',
        action: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                ),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                ),
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: textWidget(text: 'Personal Details'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Cnic:'),
                        textWidget(text: '12345-6789012-3'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'FirstName:'),
                        textWidget(text: 'Waqas'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'LastName:'),
                        textWidget(text: 'Hunain'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Email:'),
                        textWidget(text: 'abc@gmail.com'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: textWidget(text: 'Lawyer Info'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Lawyer Bio:'),
                        textWidget(text: '12345-6789012-3'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Lawyer Credential:'),
                        textWidget(text: 'Waqas'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Expertise:'),
                        textWidget(text: 'Hunain'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: textWidget(text: 'Qualification'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Degree:'),
                        textWidget(text: '12345-6789012-3'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Institute'),
                        textWidget(text: 'Waqas'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Start Date:'),
                        textWidget(text: 'Hunain'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'End Date:'),
                        textWidget(text: 'Hunain'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: textWidget(
              text: 'Working History',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Job Title'),
                        textWidget(text: '12345-6789012-3'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Employer'),
                        textWidget(text: 'Waqas'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'Start Date:'),
                        textWidget(text: 'Hunain'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: 'End Date:'),
                        textWidget(text: 'Hunain'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
