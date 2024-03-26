import 'package:case_management/utils/constants.dart';
import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/cases/bloc/case_bloc.dart';
import 'package:case_management/view/cases/bloc/case_events.dart';
import 'package:case_management/view/cases/bloc/case_states.dart';
import 'package:case_management/view/cases/case_details.dart';
import 'package:case_management/view/cases/case_proceedings.dart';
import 'package:case_management/view/history/view_history.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/cases/all_cases_response.dart';
import 'create_new_case.dart';

class Cases extends StatefulWidget {
  final bool showTile;
  final bool showOnlyClosedCases;

  const Cases({
    super.key,
    required this.showTile,
    this.showOnlyClosedCases = false,
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
                  builder: (context) => const CreateNewCase(isEdit: false),
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
        showBackArrow: true,
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
              text: 'View Attachments',
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CaseProceedings(
                    files: caseData.caseFiles,
                    pageTitle: 'Case Attachments',
                    caseTitle: 'Case Title: ${caseData.caseTitle}',
                    caseNo: caseData.caseNo,
                  ),
                ),
              ),
            ),
            _buildButton(
              text: 'View Proceedings',
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ViewHistory(
                    caseNo: caseData.caseNo,
                  ),
                ),
              ),
            ),
            _buildButton(
              text: 'Assign to Lawyer',
              onPressed: () => {},
            ),
            _buildButton(
              text: 'Assign to Client',
              onPressed: () => {},
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
