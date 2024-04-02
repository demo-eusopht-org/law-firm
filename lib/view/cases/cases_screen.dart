import 'dart:developer';

import 'package:case_management/utils/date_time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/cases/all_cases_response.dart';
import '../../utils/constants.dart';
import '../../widgets/app_dialogs.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/loader.dart';
import '../../widgets/text_widget.dart';
import '../client/clients.dart';
import '../history/view_history.dart';
import '../lawyer/lawyer_Screen.dart';
import 'bloc/case_bloc.dart';
import 'bloc/case_events.dart';
import 'bloc/case_states.dart';
import 'case_details.dart';
import 'case_proceedings.dart';
import 'create_new_case.dart';

class Cases extends StatefulWidget {
  final bool showTile;
  final bool showOnlyClosedCases;
  final bool showBackButton;

  const Cases({
    super.key,
    required this.showTile,
    this.showOnlyClosedCases = false,
    this.showBackButton = true,
  });

  @override
  State<Cases> createState() => _CasesState();
}

class _CasesState extends State<Cases> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<CaseBloc>(context).add(
        GetCasesEvent(),
      ),
    );
  }

  void _onAssignToLawyerTap(Case caseData) {
    final caseBloc = BlocProvider.of<CaseBloc>(context);
    log('CASEDATA: ${caseData.caseLawyer}');
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => LawyerScreen(
          assignedLawyer: caseData.caseLawyer?.toLawyer(),
          onSelectLawyer: (lawyer) {
            AppDialogs.showConfirmDialog(
              context: context,
              text:
                  'Are you sure you want to assign this case to ${lawyer.getDisplayName()}?',
              onConfirm: () => caseBloc.add(
                AssignLawyerEvent(
                  cnic: lawyer.cnic,
                  caseNo: caseData.caseNo,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onAssignToClientTap(Case caseData) {
    final caseBloc = BlocProvider.of<CaseBloc>(context);
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Clients(
          assignedClient: caseData.caseCustomer?.toClient(),
          onClientSelected: (client) => AppDialogs.showConfirmDialog(
            context: context,
            text:
                'Are you sure you want to assign this case to ${client.getDisplayName()}?',
            onConfirm: () => caseBloc.add(
              AssignLawyerEvent(
                caseNo: caseData.caseNo,
                cnic: client.cnic,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: Visibility(
        visible: configNotifier.value.contains(Constants.createCase),
        child: SizedBox(
          width: size.width * 0.5,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            backgroundColor: Colors.green,
            child: textWidget(
              text: 'Create a New Case',
              color: Colors.white,
              fSize: 16.0,
              fWeight: FontWeight.w700,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const CreateNewCase(),
                ),
              );
              BlocProvider.of<CaseBloc>(context).add(
                GetCasesEvent(),
              );
            },
          ),
        ),
      ),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: widget.showBackButton,
        leadingWidth: widget.showBackButton ? null : 0.0,
        title: 'Cases',
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CaseBloc, CaseState>(
      bloc: BlocProvider.of<CaseBloc>(context),
      builder: (context, state) {
        if (state is LoadingCaseState) {
          return const Loader();
        } else if (state is AllCasesState) {
          return _buildCasesList(state.cases);
        } else if (state is ErrorCaseState) {
          return Center(
            child: textWidget(
              text: state.message,
            ),
          );
        }
        return Center(
          child: textWidget(
            text: 'Something went wrong, please try again.',
          ),
        );
      },
    );
  }

  Widget _buildCasesList(List<Case> cases) {
    cases.sort((case1, case2) {
      return case1.nextHearingDate.compareTo(case2.nextHearingDate);
    });
    if (widget.showOnlyClosedCases) {
      cases.removeWhere((_case) {
        return ![1, 3, 5, 6].contains(_case.statusId);
      });
    }
    if (cases.isEmpty) {
      return Center(
        child: textWidget(
          text: widget.showOnlyClosedCases
              ? 'No closed cases available!'
              : 'No cases created yet!',
        ),
      );
    }
    return ListView.builder(
      itemCount: cases.length,
      itemBuilder: (context, index) {
        final caseData = cases[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            elevation: 5,
            child: widget.showTile
                ? _buildExpandedCaseTile(caseData, context)
                : _buildNonExpansionTile(context, caseData),
          ),
        );
      },
    );
  }

  ListTile _buildNonExpansionTile(BuildContext context, Case caseData) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.green,
              title: textWidget(
                text: "Confirmation",
              ),
              content: textWidget(
                text: "Are you sure you want to assign the case to Waqas?",
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: textWidget(text: "Yes"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: textWidget(text: "No"),
                ),
              ],
            );
          },
        );
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget(
                text: 'Case No:',
                fSize: 14.0,
              ),
              textWidget(
                text: caseData.caseNo,
                fSize: 14.0,
              ),
            ],
          ),
          textWidget(
            text: caseData.caseFilingDate.getFormattedDateTime(),
            fSize: 14.0,
          ),
          textWidget(
            text: caseData.caseStatus,
            fSize: 14.0,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedCaseTile(Case caseData, BuildContext context) {
    final showAssignClient =
        configNotifier.value.contains(Constants.assignCaseToClient) &&
            caseData.statusId != 1;
    final showAssignLawyer =
        configNotifier.value.contains(Constants.assignCaseToLawyer) &&
            caseData.statusId != 1;
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                textWidget(
                  text: 'Case No:',
                  fSize: 14.0,
                  fWeight: FontWeight.w600,
                ),
                const SizedBox(
                  width: 4,
                ),
                textWidget(
                  text: caseData.caseNo,
                  fSize: 14.0,
                ),
              ],
            ),
            Row(
              children: [
                textWidget(
                  text: 'Hearing Date:',
                  fSize: 14.0,
                  fWeight: FontWeight.w600,
                ),
                const SizedBox(
                  width: 4,
                ),
                textWidget(
                  text: caseData.nextHearingDate.getFormattedDate(),
                  fSize: 14.0,
                ),
              ],
            ),
            Row(
              children: [
                textWidget(
                  text: 'Status:',
                  fSize: 14.0,
                  fWeight: FontWeight.w600,
                ),
                const SizedBox(
                  width: 2,
                ),
                textWidget(
                  text: caseData.caseStatus,
                  fSize: 14.0,
                ),
              ],
            ),
          ],
        ),
      ),
      children: [
        GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.0,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildButton(
              text: 'View Case',
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CaseDetails(
                    caseData: caseData,
                  ),
                ),
              ),
            ),
            _buildButton(
              text: 'Attachments',
              onPressed: () async {
                final caseBloc = BlocProvider.of<CaseBloc>(context);
                await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CaseProceedings(
                      pageTitle: 'Case Attachments',
                      caseTitle: 'Case Title: ${caseData.caseTitle}',
                      caseNo: caseData.caseNo,
                    ),
                  ),
                );
                caseBloc.add(
                  GetCasesEvent(),
                );
              },
            ),
            _buildButton(
              text: 'View Proceedings',
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ViewHistory(
                    caseData: caseData,
                  ),
                ),
              ),
            ),
            if (showAssignLawyer)
              _buildButton(
                text: 'Assign to Lawyer',
                onPressed: () => _onAssignToLawyerTap(caseData),
              ),
            if (showAssignClient)
              _buildButton(
                text: 'Assign to Client',
                onPressed: () => _onAssignToClientTap(caseData),
              ),
          ],
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
