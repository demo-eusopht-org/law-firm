import 'dart:developer';

import 'package:case_management/model/get_all_lawyers_model.dart';
import 'package:case_management/utils/constants.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_bloc.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_events.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_states.dart';
import 'package:case_management/view/lawyer/lawyer_details.dart';
import 'package:case_management/view/lawyer/new_lawyer.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../model/add_experience_model.dart';
import '../../model/lawyer_request_model.dart';
import '../../model/qualification_model.dart';

class LawyerScreen extends StatefulWidget {
  const LawyerScreen({super.key});

  @override
  State<LawyerScreen> createState() => _LawyerScreenState();
}

class _LawyerScreenState extends State<LawyerScreen> {
  final _addExperience = ValueNotifier<List<AddExperienceModel>>([]);
  final _addQualification = ValueNotifier<List<AddQualificationModel>>([]);
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LawyerBloc>(context).add(GetLawyersEvent());
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
            text: 'Create a New Lawyer',
            color: Colors.white,
            fSize: 16.0,
            fWeight: FontWeight.w700,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewLawyer(
                  isEdit: false,
                ),
              ),
            );
            BlocProvider.of<LawyerBloc>(context).add(GetLawyersEvent());
          },
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
          return Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                Colors.green,
              ),
            ),
          );
        } else if (state is GetLawyersState) {
          return _buildLawyersList(state);
        } else {
          return SizedBox.shrink();
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

  Widget _buildLawyerCard(AllLawyer lawyer) {
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
                  builder: (context) => LawyerDetails(),
                ),
              );
            },
            leading: lawyer.profilePic!.isEmpty
                ? Icon(
                    Icons.hourglass_empty_outlined,
                  )
                : Image.network(
                    Constants.profileUrl + lawyer.profilePic!,
                    width: 50,
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
            trailing: Icon(Icons.visibility),
          ),
          secondaryActions: <Widget>[
            BlocBuilder<LawyerBloc, LawyerState>(
              builder: (context, state) {
                return IconSlideAction(
                  caption: 'Edit',
                  color: Colors.green,
                  icon: Icons.edit,
                  onTap: () {
                    log("USERID: ${lawyer.id}");
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => NewLawyer(
                          isEdit: true,
                          cnic: lawyer.cnic,
                          userId: lawyer.id,
                          firstName: lawyer.firstName,
                          lastName: lawyer.lastName,
                          email: lawyer.email,
                          phoneNumber: lawyer.phoneNumber,
                          lawyerCredentials: lawyer.lawyerCredentials,
                          expertise: lawyer.expertise,
                          lawyerBio: lawyer.lawyerBio,
                          experience: lawyer.experience.map((exp) {
                            return Exp(
                              jobTitle: exp.jobTitle,
                              employer: exp.employer,
                              startYear: exp.startYear,
                              endYear: exp.endYear,
                            );
                          }).toList(),
                          qualification: lawyer.qualification.map((qua) {
                            return Qualification(
                              degree: qua.degree,
                              institute: qua.institute,
                              startYear: qua.startYear,
                              endYear: qua.endYear,
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            BlocBuilder<LawyerBloc, LawyerState>(
              builder: (context, state) {
                return IconSlideAction(
                  caption: 'Delete',
                  color: Colors.green,
                  icon: Icons.delete,
                  onTap: () {
                    BlocProvider.of<LawyerBloc>(context).add(
                      DeleteLawyerEvent(cnic: lawyer.cnic ?? ''),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
