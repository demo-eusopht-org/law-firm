import 'dart:developer';

import 'package:case_management/widgets/app_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../model/lawyers/get_all_lawyers_model.dart';
import '../../utils/constants.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/loader.dart';
import '../../widgets/rounded_image_view.dart';
import '../../widgets/text_widget.dart';
import '../cases/assigned_cases.dart';
import 'lawyer_bloc/lawyer_bloc.dart';
import 'lawyer_bloc/lawyer_events.dart';
import 'lawyer_bloc/lawyer_states.dart';
import 'lawyer_details.dart';
import 'new_lawyer.dart';

class LawyerScreen extends StatefulWidget {
  final ValueSetter<AllLawyer>? onSelectLawyer;
  final AllLawyer? assignedLawyer;
  const LawyerScreen({
    super.key,
    this.assignedLawyer,
    this.onSelectLawyer,
  });

  @override
  State<LawyerScreen> createState() => _LawyerScreenState();
}

class _LawyerScreenState extends State<LawyerScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LawyerBloc>(context).add(GetLawyersEvent());
  }

  void _onDeleteTap(AllLawyer lawyer) {
    AppDialogs.showConfirmDialog(
      context: context,
      text: 'Are you sure you want to delete this lawyer?',
      onConfirm: () {
        BlocProvider.of<LawyerBloc>(context).add(
          DeleteLawyerEvent(cnic: lawyer.cnic),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: _buildCreateButton(size, context),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Lawyers',
      ),
      body: _buildBody(),
    );
  }

  Visibility _buildCreateButton(Size size, BuildContext context) {
    return Visibility(
      visible: configNotifier.value.contains(Constants.createLawyer) &&
          widget.onSelectLawyer == null,
      child: SizedBox(
        width: size.width * 0.5,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: Colors.green,
          child: textWidget(
            text: 'Create a New Lawyer',
            color: Colors.white,
            fSize: 16.0,
            fWeight: FontWeight.w700,
          ),
          onPressed: () async {
            await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (context) => const NewLawyer(),
              ),
            );
            BlocProvider.of<LawyerBloc>(context).add(
              GetLawyersEvent(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LawyerBloc, LawyerState>(
      bloc: BlocProvider.of<LawyerBloc>(context),
      builder: (context, state) {
        if (state is LoadingLawyerState) {
          return const Loader();
        } else if (state is GetLawyersState) {
          return _buildLawyersList(state);
        } else if (state is ErrorLawyerState) {
          return Center(
            child: textWidget(text: state.message),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLawyersList(GetLawyersState state) {
    if (state.lawyers.isEmpty) {
      return Center(
        child: textWidget(
          text: 'No lawyers created yet!',
        ),
      );
    }
    final allLawyers = List.of(state.lawyers);
    allLawyers.removeWhere((lawyer) {
      return lawyer.id == widget.assignedLawyer?.id;
    });
    return ListView(
      children: [
        if (widget.assignedLawyer != null)
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: textWidget(
              text: 'Lawyer already assigned to case: ',
              fWeight: FontWeight.w700,
            ),
          ),
        if (widget.assignedLawyer != null)
          _buildLawyerCard(
            widget.assignedLawyer!,
          ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: textWidget(
            text: 'All Lawyers',
            fWeight: FontWeight.w700,
          ),
        ),
        if (allLawyers.isEmpty)
          Center(
            child: textWidget(
              text: 'No lawyers created yet!',
            ),
          ),
        for (final lawyer in allLawyers) _buildLawyerCard(lawyer),
      ],
    );
  }

  Widget _buildLawyerCard(AllLawyer lawyer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Slidable(
          actionPane: const SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          enabled: widget.onSelectLawyer == null,
          secondaryActions: <Widget>[
            if (configNotifier.value.contains(Constants.updateLawyer))
              IconSlideAction(
                caption: 'Edit',
                color: Colors.green,
                icon: Icons.edit,
                onTap: () async {
                  await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewLawyer(
                        lawyer: lawyer,
                      ),
                    ),
                  );
                  BlocProvider.of<LawyerBloc>(context).add(
                    GetLawyersEvent(),
                  );
                },
              ),
            if (configNotifier.value.contains(Constants.deleteLawyer))
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => _onDeleteTap(lawyer),
              ),
          ],
          child: Builder(
            builder: (context) {
              if (widget.onSelectLawyer != null) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onSelectLawyer!(lawyer);
                  },
                  child: IgnorePointer(
                    ignoring: widget.onSelectLawyer != null,
                    child: _buildExpansionTile(lawyer),
                  ),
                );
              }
              return _buildExpansionTile(lawyer);
            },
          ),
        ),
      ),
    );
  }

  ExpansionTile _buildExpansionTile(AllLawyer lawyer) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: ListTile(
        minLeadingWidth: 50,
        leading: RoundNetworkImageView(
          size: 50,
          url: lawyer.profilePic != null
              ? Constants.getProfileUrl(
                  lawyer.profilePic!,
                  lawyer.id,
                )
              : null,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget(
              text: lawyer.firstName,
              fSize: 14.0,
            ),
            textWidget(
              text: lawyer.cnic,
              fSize: 14.0,
            ),
            textWidget(
              text: lawyer.expertise,
              fSize: 14.0,
            ),
          ],
        ),
      ),
      trailing: widget.onSelectLawyer != null ? const SizedBox.shrink() : null,
      children: _buildActions(lawyer),
    );
  }

  List<Widget> _buildActions(AllLawyer lawyer) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildContainer(
            'Assigned Cases',
            () {
              log('Lawyer ID: ${lawyer.id}');
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => AssignedCases(
                    userId: lawyer.id,
                    userDisplayName: lawyer.getDisplayName(),
                    showBackArrow: true,
                  ),
                ),
              );
            },
          ),
          buildContainer(
            'Lawyer Details',
            () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => LawyerDetails(
                  lawyer: lawyer,
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ];
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
