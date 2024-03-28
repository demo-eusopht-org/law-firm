import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/cases/case_details.dart';
import 'package:case_management/view/cause/bloc/cause_bloc.dart';
import 'package:case_management/view/cause/bloc/cause_events.dart';
import 'package:case_management/view/cause/bloc/cause_states.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../model/cases/all_cases_response.dart';
import '../../widgets/text_widget.dart';

class CauseList extends StatefulWidget {
  const CauseList({super.key});

  @override
  State<CauseList> createState() => _CauseListState();
}

class _CauseListState extends State<CauseList> {
  final _dateNotifier = ValueNotifier<DateTime?>(null);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateNotifier.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateNotifier.value) {
      _dateNotifier.value = picked;
      BlocProvider.of<CauseBloc>(context).add(
        ChangeDateCauseEvent(
          date: picked,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<CauseBloc>(context).add(
        GetCauseListEvent(),
      ),
    );
  }

  @override
  void dispose() {
    _dateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        action: [
          _buildDateTime(),
        ],
        title: 'Cause List',
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CauseBloc, CauseState>(
            bloc: BlocProvider.of<CauseBloc>(context),
            builder: (context, state) {
              if (state is LoadingCauseState) {
                return const Loader();
              } else if (state is SuccessCauseState) {
                return _buildCauseList(state.cases);
              }
              return Center(
                child: textWidget(
                  text: 'Something went wrong, please try again!',
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCauseList(List<Case> cases) {
    if (cases.isEmpty) {
      return Center(
        child: textWidget(
          text: 'No cases available!',
        ),
      );
    }
    return GroupedListView<Case, String>(
      elements: cases,
      groupBy: (_case) {
        return _case.courtLocation;
      },
      indexedItemBuilder: (context, _case, index) {
        return Card(
          color: Colors.white,
          elevation: 5,
          child: ListTile(
            onTap: () async {
              await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CaseDetails(caseData: _case),
                ),
              );
              await Future.delayed(const Duration(milliseconds: 100));
              BlocProvider.of<CauseBloc>(context).add(
                GetCauseListEvent(),
              );
            },
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: textWidget(
                    text: '${index + 1}',
                    // fSize: 10.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                        text: _case.caseTitle,
                        fSize: 12.0,
                        color: Colors.black,
                      ),
                      textWidget(
                        text: _case.caseNo,
                        fSize: 12.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      groupHeaderBuilder: (Case _case) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.green,
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                textWidget(
                  text: _case.courtLocation,
                  color: Colors.white,
                  fSize: 18.0,
                  fWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded table(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        color: Colors.red,
        child: textWidget(
          text: text,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDateTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: _dateNotifier,
          builder: (context, date, child) {
            return textWidget(
              text: date == null ? 'Today' : date.getFormattedDate(),
              color: Colors.white,
              fWeight: FontWeight.w600,
            );
          },
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<CauseBloc>(context).add(
              ChangeDateCauseEvent(date: null),
            );
            _dateNotifier.value = null;
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
