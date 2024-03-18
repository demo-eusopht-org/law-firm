import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/history/bloc/history_bloc.dart';
import 'package:case_management/view/history/bloc/history_events.dart';
import 'package:case_management/view/history/bloc/history_states.dart';
import 'package:case_management/view/history/history_detail.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../model/cases/case_history_response.dart';

class ViewHistory extends StatefulWidget {
  final String caseNo;
  const ViewHistory({
    super.key,
    required this.caseNo,
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
          caseNo: widget.caseNo,
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
          return _buildHistory(state.history);
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildHistory(List<CaseHistory> history) {
    if (history.isEmpty) {
      return Center(
        child: Text(
          'No history available for case: ${widget.caseNo}',
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
                text: item.hearingDate.getFormattedDate(),
                fSize: 11.0,
              ),
            ),
          ),
          beforeLineStyle: LineStyle(
            color: Colors.red,
            thickness: 3,
          ),
          // startChild: textWidget(
          //   text: item['Date']!,
          //   fSize: 12.0,
          //   fWeight: FontWeight.w700,
          // ),
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
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: 'Case No:',
                    fSize: 13.0,
                    fWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  textWidget(
                    text: widget.caseNo,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: 'Proceedings: ',
                    fSize: 13.0,
                    fWeight: FontWeight.w600,
                  ),
                  textWidget(
                    text: item.hearingProceedings,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  textWidget(
                    text: 'Judge Name: ',
                    fSize: 13.0,
                    fWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  textWidget(
                    text: item.judgeName,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: 'Status:',
                    fSize: 13.0,
                    fWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  textWidget(
                    text: item.caseStatusName,
                  ),
                ],
              ),
              Align(
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
}
