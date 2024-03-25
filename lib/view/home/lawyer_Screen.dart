import 'dart:developer';

import 'package:case_management/model/get_all_lawyers_model.dart';
import 'package:case_management/utils/constants.dart';
import 'package:case_management/view/cases/assigned_cases.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_bloc.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_events.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_states.dart';
import 'package:case_management/view/lawyer/lawyer_details.dart';
import 'package:case_management/view/lawyer/new_lawyer.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../widgets/rounded_image_view.dart';

class LawyerScreen extends StatefulWidget {
  const LawyerScreen({super.key});

  @override
  State<LawyerScreen> createState() => _LawyerScreenState();
}

class _LawyerScreenState extends State<LawyerScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LawyerBloc>(context).add(GetLawyersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: Visibility(
        visible: configNotifier.value.contains(Constants.createLawyer),
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
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewLawyer(),
                ),
              );
              BlocProvider.of<LawyerBloc>(context).add(GetLawyersEvent());
            },
          ),
        ),
      ),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Lawyers',
      ),
      body: _buildBody(),
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
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLawyersList(GetLawyersState state) {
    final lawyerData = state.lawyers.where((lawyer) {
      return true;
    }).toList();
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: textWidget(
            text: 'Active Lawyers',
          ),
        ),
        ...lawyerData.map((lawyer) {
          return _buildLawyerCard(lawyer);
        }),
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

  Widget _buildLawyerCard(AllLawyer lawyer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Slidable(
          actionPane: const SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            if (configNotifier.value.contains(Constants.updateLawyer))
              IconSlideAction(
                caption: 'Edit',
                color: Colors.green,
                icon: Icons.edit,
                onTap: () {
                  log("USERID: ${lawyer.id}");
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => NewLawyer(
                        lawyer: lawyer,
                      ),
                    ),
                  );
                },
              ),
            if (configNotifier.value.contains(Constants.deleteLawyer))
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  BlocProvider.of<LawyerBloc>(context).add(
                    DeleteLawyerEvent(cnic: lawyer.cnic ?? ''),
                  );
                },
              ),
          ],
          child: ExpansionTile(
            childrenPadding: const EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(side: BorderSide.none),
            title: ListTile(
              minLeadingWidth: 50,
              leading: RoundImageView(
                size: 50,
                url: Constants.getProfileUrl(
                  lawyer.profilePic!,
                  lawyer.id!,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: lawyer.firstName ?? '',
                    fSize: 14.0,
                  ),
                  textWidget(
                    text: lawyer.cnic ?? '',
                    fSize: 14.0,
                  ),
                  textWidget(
                    text: lawyer.expertise ?? '',
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
                    'Assigned Cases',
                    () {
                      if (lawyer.id != null) {
                        log('Lawyer ID: ${lawyer.id}');
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AssignedCases(
                              userId: lawyer.id!,
                              userDisplayName: lawyer.getDisplayName(),
                              showBackArrow: true,
                            ),
                          ),
                        );
                      } else {
                        CustomToast.show(
                          'No ID is associated with lawyer!',
                        );
                      }
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
