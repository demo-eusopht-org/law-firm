import 'package:case_management/utils/constants.dart';
import 'package:case_management/view/customer/client_bloc/client_events.dart';
import 'package:case_management/view/customer/client_bloc/client_states.dart';
import 'package:case_management/view/customer/create_customer.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
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
    BlocProvider.of<ClientBloc>(context).add(
      GetClientsEvent(),
    );
  }

  Future<void> _onEditTapped(Client client) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => CreateCustomer(
          client: client,
        ),
      ),
    );
    if (result != null) {
      if (result) {
        BlocProvider.of<ClientBloc>(context).add(
          GetClientsEvent(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildCreateButton(context),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Clients',
      ),
      body: _buildBody(),
    );
  }

  Visibility _buildCreateButton(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Visibility(
      visible: configNotifier.value.contains(Constants.createClient),
      child: SizedBox(
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
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateCustomer(),
              ),
            );
            if (result != null) {
              if (result) {
                BlocProvider.of<ClientBloc>(context).add(
                  GetClientsEvent(),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ClientBloc, ClientState>(
      bloc: BlocProvider.of<ClientBloc>(context),
      builder: (context, state) {
        if (state is LoadingClientState) {
          return const Loader();
        } else if (state is GetClientState) {
          return _buildClientList(state);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildClientList(GetClientState state) {
    final clientData = state.client.where((client) {
      return true;
    }).toList();
    return ListView(
      children: clientData.map((client) {
        return _buildClientCard(client);
      }).toList(),
    );
  }

  Widget _buildClientCard(Client client) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Slidable(
          actionPane: const SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            if (configNotifier.value.contains(Constants.updateClient))
              IconSlideAction(
                caption: 'Edit',
                color: Colors.green,
                icon: Icons.edit,
                onTap: () => _onEditTapped(client),
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
            ),
          ],
          child: ExpansionTile(
            childrenPadding: const EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(side: BorderSide.none),
            title: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: client.getDisplayName(),
                    fSize: 14.0,
                  ),
                  textWidget(
                    text: client.email,
                    fSize: 14.0,
                  ),
                  textWidget(
                    text: client.cnic,
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
                        builder: (context) => const Cases(
                          showTile: false,
                        ),
                      ),
                    ),
                  ),
                  buildContainer(
                    'Client Details',
                    () async {
                      await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CustomerDetails(
                            user: client,
                          ),
                        ),
                      );
                      BlocProvider.of<ClientBloc>(context).add(
                        GetClientsEvent(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(String text, void Function() onPressed) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 42),
          backgroundColor: Colors.green,
        ),
        onPressed: onPressed,
        child: textWidget(
          text: text,
          fSize: 13.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
