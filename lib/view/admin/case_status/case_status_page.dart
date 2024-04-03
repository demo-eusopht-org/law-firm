import 'package:case_management/view/admin/bloc/admin_states.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../model/cases/case_status.dart';
import '../../../widgets/appbar_widget.dart';
import '../../../widgets/loader.dart';
import '../bloc/admin_bloc.dart';
import '../bloc/admin_events.dart';

class CaseStatusPage extends StatefulWidget {
  const CaseStatusPage({super.key});

  @override
  State<CaseStatusPage> createState() => _CaseStatusPageState();
}

class _CaseStatusPageState extends State<CaseStatusPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<AdminBloc>(context).add(
        GetStatusAdminEvent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        title: 'Case Status CRUD',
        showBackArrow: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      bloc: BlocProvider.of<AdminBloc>(context),
      builder: (context, state) {
        if (state is LoadingAdminState) {
          return const Loader();
        } else if (state is ErrorAdminState) {
          return Center(
            child: textWidget(text: state.message),
          );
        } else if (state is GotStatusAdminState) {
          return _buildStatusList(state.statuses);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildStatusList(List<CaseStatus> statuses) {
    if (statuses.isEmpty) {
      return Center(
        child: textWidget(text: 'No statuses found, kindly create one now!'),
      );
    }
    return ListView.builder(
      itemCount: statuses.length,
      itemBuilder: (context, index) {
        final status = statuses[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Slidable(
            actionPane: const SlidableStrechActionPane(),
            actionExtentRatio: 0.25,
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
                onTap: () {},
              ),
            ],
            child: ListTile(
              title: textWidget(text: status.statusName),
              subtitle: textWidget(text: 'ID: ${status.id}'),
              leading: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.green,
                child: textWidget(
                  text: '${index + 1}',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
