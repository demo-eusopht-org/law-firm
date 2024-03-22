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
  const AssignedCases({super.key});

  @override
  State<AssignedCases> createState() => _AssignedCasesState();
}

class _AssignedCasesState extends State<AssignedCases> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userId = locator<LocalStorageService>().getData('id');
      BlocProvider.of<CaseBloc>(context).add(
        GetUserCasesEvent(
          userId: userId!,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: false,
        title: 'My Assigned Cases',
        leadingWidth: 0.0,
        // action: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.calendar_month,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       _selectDate(context);
        //     },
        //   ),
        // ],
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
        return Center(
          child: Text('Something went wrong!'),
        );
      },
    );
  }

  Widget _buildCases(List<Case> cases) {
    final todayCases = cases.where((_case) {
      return _case.nextHearingDate.isToday;
    }).toList();
    final tomorrowCases = cases.where((_case) {
      return _case.nextHearingDate.isTomorrow;
    }).toList();
    final allRemainingCases = cases.where((_case) {
      return !todayCases.contains(_case) && !tomorrowCases.contains(_case);
    }).toList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLabeledCases(
            'Today',
            todayCases,
          ),
          SizedBox(
            height: 10,
          ),
          _buildLabeledCases(
            'Tomorrow',
            tomorrowCases,
          ),
          SizedBox(
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
            Expanded(
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
          actionPane: SlidableStrechActionPane(),
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
        SizedBox(
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
