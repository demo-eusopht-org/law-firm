import 'package:case_management/view/cause/bloc/cause_bloc.dart';
import 'package:case_management/view/cause/bloc/cause_events.dart';
import 'package:case_management/view/cause/bloc/cause_states.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
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
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      // widget.onDateChanged?.call(picked);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Cause List',
        action: [
          textWidget(
            text: '(3-5-2024)',
            color: Colors.white,
            fWeight: FontWeight.w600,
          ),
          IconButton(
            onPressed: () {
              _selectDate(context);
            },
            icon: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CauseBloc, CauseState>(
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
    );
  }

  Widget _buildCauseList(List<Case> cases) {
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
            title: Row(
              children: [
                textWidget(
                  text: '${index + 1}',
                  fSize: 10.0,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: textWidget(
                    text: _case.caseTitle,
                    fSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     CupertinoPageRoute(
            //       builder: (context) => CauseListDetail(),
            //     ),
            //   );
            // },
          ),
        );
      },
      groupHeaderBuilder: (Case _case) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.green,
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
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

  Expanded table(String Text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        color: Colors.red,
        child: textWidget(
          text: '$Text',
          color: Colors.white,
        ),
      ),
    );
  }
}
