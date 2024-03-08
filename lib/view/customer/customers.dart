import 'package:case_management/view/customer/customer_details.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../widgets/text_widget.dart';
import 'create_customer.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  final List<Map<String, String>> customers = [
    {
      'firstname': 'Waqas',
      'lastname': 'Bashir',
      'email': 'abc@gmail.com',
      'description': 'LLB,MBBS',
      'cnic': '12345-6789012-3',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: Container(
        width: size.width * 0.52,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              23,
            ),
          ),
          backgroundColor: Colors.green,
          child: textWidget(
            text: 'Create a New Client',
            color: Colors.white,
            fSize: 16.0,
            fWeight: FontWeight.w700,
          ),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CreateCustomer(),
              ),
            );
          },
        ),
      ),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Client',
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final lawyer = customers[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: Slidable(
                actionPane: SlidableStrechActionPane(),
                actionExtentRatio: 0.25,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CustomerDetails(),
                      ),
                    );
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                        text: '${lawyer['firstname']}',
                        fSize: 14.0,
                      ),
                      textWidget(
                        text: '${lawyer['lastname']}',
                        fSize: 14.0,
                      ),
                      textWidget(
                        text: '${lawyer['email']}',
                        fSize: 14.0,
                      ),
                      textWidget(
                        text: '${lawyer['cnic']}',
                        fSize: 14.0,
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.visibility),
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
        },
      ),
    );
  }
}
