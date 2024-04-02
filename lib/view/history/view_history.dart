import 'package:case_management/utils/constants.dart';
import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/cases/add_proceedings.dart';
import 'package:case_management/view/history/bloc/history_bloc.dart';
import 'package:case_management/view/history/bloc/history_events.dart';
import 'package:case_management/view/history/bloc/history_states.dart';
import 'package:case_management/view/history/history_detail.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../model/cases/all_cases_response.dart';
import '../../model/cases/case_history_response.dart';

class ViewHistory extends StatefulWidget {
  final Case caseData;
  const ViewHistory({
    super.key,
    required this.caseData,
  });

  @override
  State<ViewHistory> createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<HistoryBloc>(context).add(
        GetHistoryEvent(
          caseData: widget.caseData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'View Proceedings',
      ),
      floatingActionButton: Visibility(
        visible: configNotifier.value.contains(Constants.addProceedings),
        child: RoundedElevatedButton(
          text: 'Add proceeding',
          onPressed: () async {
            await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => AddProceedings(
                  caseNo: widget.caseData.caseNo,
                ),
              ),
            );
            BlocProvider.of<HistoryBloc>(context).add(
              GetHistoryEvent(
                caseData: widget.caseData,
              ),
            );
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HistoryBloc, HistoryState>(
      bloc: BlocProvider.of<HistoryBloc>(context),
      builder: (context, state) {
        if (state is LoadingHistoryState) {
          return const Loader();
        } else if (state is SuccessGetHistoryState) {
          final historyList = List.of(state.history);
          historyList.sort((h1, h2) {
            return h2.createdAt.compareTo(h1.createdAt);
          });
          return _buildHistory(historyList);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHistory(List<CaseHistory> history) {
    if (history.isEmpty) {
      return Center(
        child: Text(
          'No proceedings available for case: ${widget.caseData.caseNo}',
        ),
      );
    }

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return TimelineTile(
          hasIndicator: true,
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isFirst: index == 0,
          isLast: index == history.length - 1,
          indicatorStyle: IndicatorStyle(
            drawGap: true,
            width: 80,
            height: 30,
            indicator: Center(
              child: textWidget(
                text: item.createdAt.getFormattedDate(),
                fSize: 11.0,
              ),
            ),
          ),
          beforeLineStyle: const LineStyle(
            color: Colors.red,
            thickness: 3,
          ),
          endChild: Padding(
            padding: const EdgeInsets.all(6.0),
            child: _buildHistoryCard(
              item,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryCard(CaseHistory item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => HistoryDetail(
              history: item,
              caseNo: widget.caseData.caseNo,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildValueRow(
                label: 'Case No: ',
                value: widget.caseData.caseNo,
              ),
              const SizedBox(
                height: 5,
              ),
              _buildValueRow(
                label: 'Proceedings: ',
                value: item.hearingProceedings,
              ),
              const SizedBox(
                height: 5,
              ),
              _buildValueRow(
                label: 'Judge Name: ',
                value: item.judgeName,
              ),
              const SizedBox(
                height: 5,
              ),
              _buildValueRow(
                label: 'Status: ',
                value: item.caseStatusName,
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.green,
                  size: 24,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueRow({
    required String label,
    required String value,
  }) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13.0,
          color: Colors.black,
          fontFamily: 'Mulish',
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }
}
