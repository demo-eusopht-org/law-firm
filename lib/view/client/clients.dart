import 'package:case_management/view/cases/assigned_cases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../model/lawyers/all_clients_response.dart';
import '../../utils/constants.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/loader.dart';
import '../../widgets/rounded_image_view.dart';
import '../../widgets/text_widget.dart';
import 'client_bloc/client_bloc.dart';
import 'client_bloc/client_events.dart';
import 'client_bloc/client_states.dart';
import 'client_details.dart';
import 'create_client.dart';

class Clients extends StatefulWidget {
  final ValueSetter<Client>? onClientSelected;
  const Clients({
    super.key,
    this.onClientSelected,
  });

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
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

  void _listener(BuildContext context, ClientState state) {
    if (state is DeletedClientState) {
      BlocProvider.of<ClientBloc>(context).add(
        GetClientsEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<ClientBloc>(context),
      listener: _listener,
      child: Scaffold(
        floatingActionButton: _buildCreateButton(context),
        appBar: AppBarWidget(
          context: context,
          showBackArrow: true,
          title: 'Clients',
        ),
        body: _buildBody(),
      ),
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
    final clients = state.client.where((client) {
      return true;
    }).toList();
    if (clients.isEmpty) {
      return Center(
        child: textWidget(
          text: 'No clients found!',
        ),
      );
    }
    return ListView(
      children: clients.map((client) {
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
          enabled: widget.onClientSelected == null,
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
              onTap: () => BlocProvider.of<ClientBloc>(context).add(
                DeleteClientEvent(
                  cnic: client.cnic,
                ),
              ),
            ),
          ],
          child: Builder(
            builder: (context) {
              if (widget.onClientSelected != null) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onClientSelected!(client);
                  },
                  child: IgnorePointer(
                    child: _buildExpansionTile(client),
                  ),
                );
              }
              return _buildExpansionTile(client);
            },
          ),
        ),
      ),
    );
  }

  ExpansionTile _buildExpansionTile(Client client) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: ListTile(
        leading: RoundNetworkImageView(
          url: Constants.getProfileUrl(
            client.profilePic,
            client.id,
          ),
          size: 50,
        ),
        minLeadingWidth: 50,
        contentPadding: EdgeInsets.zero,
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
      trailing:
          widget.onClientSelected != null ? const SizedBox.shrink() : null,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(
              text: 'Assigned Cases',
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => AssignedCases(
                    userId: client.id,
                    userDisplayName: client.getDisplayName(),
                    showBackArrow: true,
                  ),
                ),
              ),
            ),
            _buildButton(
              text: 'Client Details',
              onPressed: () async {
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
    );
  }

  Container _buildButton({
    required String text,
    required VoidCallback onPressed,
  }) {
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
