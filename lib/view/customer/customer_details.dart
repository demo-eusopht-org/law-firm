import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final List<Map<String, String>> customerDetails = [
    {
      'id': '001',
      'firstName': 'Waqas',
      'lastName': 'Bashir',
      'description': 'LLB,MBBS',
      'cnic': '12345-6789012-3',
      'email': 'abc@gmail.com'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          context: context,
          showBackArrow: true,
          title: 'Client Details',
          // action: [
          //   Row(
          //     children: [
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.edit,
          //         ),
          //         color: Colors.white,
          //       ),
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.delete,
          //         ),
          //         color: Colors.white,
          //       ),
          //     ],
          //   ),
          // ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
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
            Expanded(
                child: ListView.builder(
              itemCount: customerDetails.length,
              itemBuilder: (context, index) {
                final lawyer = customerDetails[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCard(
                        lawyer,
                        'First Name',
                        'firstName',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Last Name',
                        'lastName',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Email',
                        'email',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Cnic',
                        'cnic',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              },
            ))
          ],
        ));
  }

  Widget buildCard(Map<String, String> lawyer, String label, String text) {
    return SizedBox(
      height: 60,
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget(text: label),
              textWidget(
                text: '${lawyer[text]}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
