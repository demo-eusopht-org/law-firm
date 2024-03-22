import 'package:case_management/utils/app_assets.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomerDetails extends StatefulWidget {
  String cnic;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;

  CustomerDetails({
    super.key,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.cnic,
    required this.phoneNumber,
  });

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  late final List<Map<String, String>> customers;
  final List<Map<String, String>> cases = [
    {
      'id': '001',
      'Date': '2/28/2024',
      'Status': 'Pending',
      'description': 'LLB,MBBS',
      'cnic': '12345-6789012-3',
    },
    {
      'id': '002',
      'Date': '2/28/2024',
      'Status': 'Approved',
      'description': 'LLB,MBBS',
      'cnic': '12345-6789012-3',
    },
  ];

  final List<Map<String, String>> inActive = [
    {
      'id': '004',
      'firstName': 'Ali',
      'lastName': 'Hussain',
      'description': 'MBBS',
      'cnic': '12345-6789012-7',
      'Status': 'Approved',
      'Date': '2/28/2024',
    },
    {
      'id': '009',
      'firstName': 'Salman',
      'lastName': 'Hussain',
      'description': 'MBBS',
      'cnic': '12345-6789012-9',
      'Status': 'Approved',
      'Date': '2/28/2024',
    },
  ];
  @override
  void initState() {
    super.initState();
    customers = [
      {
        'firstName': widget.lastName,
        'lastname': widget.firstName,
        'email': widget.email,
        'cnic': widget.cnic,
        'phonenumber': widget.phoneNumber,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Client Details',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
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
          SizedBox(
            height: 10,
          ),
          buildExpanded(),
        ],
      ),
    );
  }

  Expanded buildExpanded() {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'Personal Details',
            ),
          ),
          ...customers.map((lawyer) {
            return _buildLawyerCard(lawyer);
          }).toList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'Active Cases',
            ),
          ),
          ...cases.map((_case) {
            return _buildLCaseCard(_case);
          }).toList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'Inactive Cases',
            ),
          ),
          ...inActive.map((_case) {
            return _buildLCaseCard(_case);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildLawyerCard(Map<String, String> lawyer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'Cnic',
                      fSize: 14.0,
                    ),
                    textWidget(
                      text: '${lawyer['cnic']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'FirstName',
                      fSize: 14.0,
                    ),
                    textWidget(
                      text: '${lawyer['firstName']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'LastName',
                      fSize: 14.0,
                    ),
                    textWidget(
                      text: '${lawyer['lastname']}',
                      fSize: 14.0,
                    ),
                  ],
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     textWidget(
                //       text: 'Description',
                //       fSize: 14.0,
                //     ),
                //     textWidget(
                //       text: '${lawyer['description']}',
                //       fSize: 14.0,
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'Email',
                      fSize: 14.0,
                    ),
                    textWidget(
                      text: '${lawyer['email']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'Phone Number',
                      fSize: 14.0,
                    ),
                    textWidget(
                      text: '${lawyer['phonenumber']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color: Colors.green,
              icon: Icons.edit,
              onTap: () {},
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.green,
              icon: Icons.delete,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLCaseCard(Map<String, String> lawyer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'Case No:',
                      fSize: 14.0,
                      fWeight: FontWeight.w500,
                    ),
                    textWidget(
                      text: '${lawyer['id']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'Date:',
                      fSize: 14.0,
                      fWeight: FontWeight.w500,
                    ),
                    textWidget(
                      text: '${lawyer['Date']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'Status:',
                      fSize: 14.0,
                      fWeight: FontWeight.w500,
                    ),
                    textWidget(
                      text: '${lawyer['Status']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color: Colors.green,
              icon: Icons.edit,
              onTap: () {},
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.green,
              icon: Icons.delete,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
