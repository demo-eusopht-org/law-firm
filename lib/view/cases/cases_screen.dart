import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/cases/bloc/case_bloc.dart';
import 'package:case_management/view/cases/bloc/case_events.dart';
import 'package:case_management/view/cases/bloc/case_states.dart';
import 'package:case_management/view/cases/case_details.dart';
import 'package:case_management/view/history/view_history.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/cases/all_cases_response.dart';
import 'case_attachments.dart';
import 'create_new_case.dart';

class Cases extends StatefulWidget {
  bool showTile = false;
  Cases({
    super.key,
    required this.showTile,
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
      floatingActionButton: Container(
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
                builder: (context) => CreateNewCase(isEdit: false),
              ),
            );
            BlocProvider.of<CaseBloc>(context).add(
              GetCasesEvent(),
            );
          },
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
        return const Loader();
      },
    );
  }

  Widget _buildCasesList(List<Case> cases) {
    if (cases.isEmpty) {
      return Center(
        child: Text('No cases created yet!'),
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
                : ListTile(
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
                              text:
                                  "Are you sure you want to assign the case to Waqas?",
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
                        textWidget(
                          text: caseData.caseNo,
                          fSize: 14.0,
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
                  ),
          ),
        );
      },
    );
  }

  Widget _buildExpandedCaseTile(Case caseData, BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(side: BorderSide.none),
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
                SizedBox(
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
                  text: 'Date:',
                  fSize: 14.0,
                  fWeight: FontWeight.w600,
                ),
                SizedBox(
                  width: 4,
                ),
                textWidget(
                  text: caseData.caseFilingDate.getFormattedDateTime(),
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
                SizedBox(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildContainer(
              'View Case',
              () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CaseDetails(
                    caseData: caseData,
                  ),
                ),
              ),
            ),
            buildContainer(
              'View Attachments',
              () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CaseAttachments(
                    caseData: caseData,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildContainer(
              'View Proceedings',
              () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ViewHistory(
                    caseNo: caseData.caseNo,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildContainer(
              'Assign to Lawyer',
              () => {},
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        buildContainer(
          'Assign to Client',
          () => {},
        ),
      ],
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
