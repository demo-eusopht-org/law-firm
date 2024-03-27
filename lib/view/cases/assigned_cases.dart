import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/cases/bloc/case_bloc.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../model/cases/all_cases_response.dart';
import '../../widgets/text_widget.dart';
import 'bloc/case_events.dart';
import 'bloc/case_states.dart';

class AssignedCases extends StatefulWidget {
  final int userId;
  final String userDisplayName;
  final bool showBackArrow;
  const AssignedCases({
    super.key,
    required this.userId,
    required this.userDisplayName,
    this.showBackArrow = false,
  });

  @override
  State<AssignedCases> createState() => _AssignedCasesState();
}

class _AssignedCasesState extends State<AssignedCases> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<CaseBloc>(context).add(
        GetUserCasesEvent(
          userId: widget.userId,
        ),
      );
    });
  }

  String _getTitle() {
    final userId = locator<LocalStorageService>().getData('id');
    if (widget.userId == userId) {
      return 'My Assigned Tasks';
    } else {
      return 'Assigned Tasks for ${widget.userDisplayName}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: widget.showBackArrow,
        title: _getTitle(),
        leadingWidth: widget.showBackArrow ? 40 : 0.0,
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
          return _buildCases(state.cases);
        }
        return const Center(
          child: Text('Something went wrong!'),
        );
      },
    );
  }

  Widget _buildCases(List<Case> cases) {
    cases.sort((case1, case2) {
      return case1.nextHearingDate.compareTo(case2.nextHearingDate);
    });
    final todayCases = cases.where((_case) {
      return _case.nextHearingDate.isToday;
    }).toList();
    final tomorrowCases = cases.where((_case) {
      return _case.nextHearingDate.isTomorrow;
    }).toList();
    final allRemainingCases = cases.where((_case) {
      return !todayCases.contains(_case) &&
          !tomorrowCases.contains(_case) &&
          _case.nextHearingDate.isAfter(DateTime.now());
    }).toList();

    if (cases.isEmpty) {
      return Center(
        child: textWidget(
          text: 'No cases available for ${widget.userDisplayName}',
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLabeledCases(
            'Today',
            todayCases,
          ),
          const SizedBox(
            height: 10,
          ),
          _buildLabeledCases(
            'Tomorrow',
            tomorrowCases,
          ),
          const SizedBox(
            height: 10,
          ),
          _buildLabeledCases(
            'All Cases',
            allRemainingCases,
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledCases(String label, List<Case> cases) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: textWidget(
                text: label,
                fWeight: FontWeight.w600,
                fSize: 18.0,
              ),
            ),
            const Expanded(
              child: Divider(
                endIndent: 8,
              ),
            ),
          ],
        ),
        if (cases.isEmpty)
          Center(
            child: textWidget(text: 'No tasks available for $label'),
          ),
        ...cases.map((_case) {
          return _buildCaseCard(_case);
        }).toList(),
      ],
    );
  }

  Widget _buildCaseCard(Case _case) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Slidable(
          actionPane: const SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRowItem(
                  'Case No: ',
                  _case.caseNo,
                ),
                _buildRowItem(
                  'Hearing Date: ',
                  _case.nextHearingDate.getFormattedDate(),
                ),
                _buildRowItem(
                  'Status: ',
                  _case.caseStatus,
                ),
                _buildRowItem(
                  'Title: ',
                  _case.caseTitle,
                ),
                _buildRowItem(
                  'Court: ',
                  _case.courtLocation,
                ),
              ],
            ),
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Row _buildRowItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textWidget(
          text: label,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: textWidget(
            text: value,
            fSize: 14.0,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
