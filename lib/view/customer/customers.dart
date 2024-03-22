import 'package:case_management/view/customer/client_bloc/client_events.dart';
import 'package:case_management/view/customer/client_bloc/client_states.dart';
import 'package:case_management/view/customer/create_customer.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../model/lawyers/all_clients_response.dart';
import '../cases/cases_screen.dart';
import 'client_bloc/client_bloc.dart';
import 'customer_details.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClientBloc>(context).add(GetClientsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: Container(
        width: size.width * 0.5,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: Colors.green,
          child: textWidget(
            text: 'Create a New Client',
            color: Colors.white,
            fSize: 16.0,
            fWeight: FontWeight.w700,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateCustomer(),
              ),
            );
            BlocProvider.of<ClientBloc>(context).add(GetClientsEvent());
          },
        ),
      ),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Clients',
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ClientBloc, ClientState>(
      bloc: BlocProvider.of<ClientBloc>(context),
      builder: (context, state) {
        if (state is LoadingClientState) {
          return Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                Colors.green,
              ),
            ),
          );
        } else if (state is GetClientState) {
          return _buildLawyersList(state);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLawyersList(GetClientState state) {
    final clientData = state.client.where((client) {
      return true;
    }).toList();
    return ListView(
      children: [
        ...clientData.map((client) {
          return _buildLawyerCard(client);
        }).toList(),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: textWidget(
        //     text: 'Inactive Lawyers',
        //   ),
        // ),
        // ...inActive.map((lawyer) {
        //   return _buildLawyerCard(lawyer);
        // }).toList(),
      ],
    );
  }

  Widget _buildLawyerCard(Client client) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Slidable(
            actionPane: SlidableStrechActionPane(),
            actionExtentRatio: 0.25,
            child: ExpansionTile(
              childrenPadding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(side: BorderSide.none),
              title: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                      text: '${client.firstName}',
                      fSize: 14.0,
                    ),
                    textWidget(
                      text: '${client.email}',
                      fSize: 14.0,
                    ),
                    textWidget(
                      text: '${client.cnic}',
                      fSize: 14.0,
                    ),
                  ],
                ),
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildContainer(
                      'Assigned Case To',
                      () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Cases(
                            showTile: false,
                          ),
                        ),
                      ),
                    ),
                    buildContainer(
                      'Client Details',
                      () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CustomerDetails(
                            cnic: client.cnic,
                            lastName: client.firstName,
                            firstName: client.lastName,
                            email: client.email,
                            phoneNumber: client.phoneNumber,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
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
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  // BlocProvider.of<LawyerBloc>(context).add(
                  //   DeleteLawyerEvent(cnic: lawyer.cnic ?? ''),
                  // );
                },
              )
            ]),
      ),
    );
  }

  Container buildContainer(String text, void Function() onPressed) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(150, 42),
          backgroundColor: Colors.green,
        ),
        child: textWidget(
          text: text,
          fSize: 13.0,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

// import 'package:case_management/view/cases/cases.dart';
// import 'package:case_management/view/customer/client_bloc/client_bloc.dart';
// import 'package:case_management/view/customer/client_bloc/client_events.dart';
// import 'package:case_management/view/customer/client_bloc/client_states.dart';
// import 'package:case_management/view/customer/customer_details.dart';
// import 'package:case_management/widgets/appbar_widget.dart';
// import 'package:case_management/widgets/loader.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../widgets/text_widget.dart';
// import 'create_customer.dart';
//
// class Customers extends StatefulWidget {
//   Customers({
//     super.key,
//   });
//
//   @override
//   State<Customers> createState() => _CustomersState();
// }
//
// class _CustomersState extends State<Customers> {
//   final List<Map<String, String>> customers = [
//     {
//       'firstname': 'Waqas',
//       'lastname': 'Bashir',
//       'email': 'abc@gmail.com',
//       'description': 'LLB,MBBS',
//       'cnic': '12345-6789012-3',
//     },
//   ];
//   final List<Map<String, String>> inActive = [
//     {
//       'id': '1',
//       'firstName': 'Ali',
//       'lastName': 'Hussain',
//       'description': 'MBBS',
//       'cnic': '12345-6789012-7',
//     },
//     {
//       'id': '1',
//       'firstName': 'Salman',
//       'lastName': 'Hussain',
//       'description': 'MBBS',
//       'cnic': '12345-6789012-9',
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     return Scaffold(
//       floatingActionButton: Container(
//         width: size.width * 0.52,
//         child: FloatingActionButton(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(
//               23,
//             ),
//           ),
//           backgroundColor: Colors.green,
//           child: textWidget(
//             text: 'Create a New Client',
//             color: Colors.white,
//             fSize: 16.0,
//             fWeight: FontWeight.w700,
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               CupertinoPageRoute(
//                 builder: (context) => CreateCustomer(),
//               ),
//             );
//             BlocProvider.of<ClientBloc>(context).add(GetClientsEvent());
//           },
//         ),
//       ),
//       appBar: AppBarWidget(
//         context: context,
//         showBackArrow: true,
//         title: 'Client',
//       ),
//       body: BlocBuilder<ClientBloc, ClientState>(
//         bloc: BlocProvider.of<ClientBloc>(context),
//         builder: (context, state) {
//           if (state is LoadingClientState) {
//             return const Loader();
//           } else if (state is GetClientState) {
//             return Column(
//               children: [
//                 buildclientCard(state),
//               ],
//             );
//           } else {
//             return SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
//
//   Widget buildclientCard(GetClientState state) {
//     final lawyerData = state.client.where((client) {
//       return true;
//     }).toList();
//     return Expanded(
//       child: ListView.builder(
//         itemCount: lawyerData.length,
//         itemBuilder: (context, index) {
//           final client = lawyerData[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               color: Colors.white,
//               elevation: 5,
//               child: ExpansionTile(
//                 childrenPadding: EdgeInsets.all(10),
//                 shape: RoundedRectangleBorder(side: BorderSide.none),
//                 title: ListTile(
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       textWidget(
//                         text: '${lawyerData[index].firstName}',
//                         fSize: 14.0,
//                       ),
//                       textWidget(
//                         text: client.description,
//                         fSize: 14.0,
//                       ),
//                       textWidget(
//                         text: client.cnic,
//                         fSize: 14.0,
//                       ),
//                     ],
//                   ),
//                 ),
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildContainer(
//                         'Assigned Case To',
//                         () => Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) => Cases(
//                               showTile: false,
//                             ),
//                           ),
//                         ),
//                       ),
//                       buildContainer(
//                         'Client Details',
//                         () => Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) => CustomerDetails(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Container buildContainer(String text, void Function() onPressed) {
//     return Container(
//       alignment: Alignment.center,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           minimumSize: Size(150, 42),
//           backgroundColor: Colors.green,
//         ),
//         child: textWidget(
//           text: text,
//           fSize: 13.0,
//           color: Colors.white,
//         ),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }
