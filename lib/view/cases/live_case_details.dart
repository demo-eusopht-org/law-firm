import 'package:case_management/view/cases/bloc/case_bloc.dart';
import 'package:case_management/view/cases/bloc/case_events.dart';
import 'package:case_management/view/cases/bloc/case_states.dart';
import 'package:case_management/view/cases/case_details.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveCaseDetails extends StatefulWidget {
  final String caseNo;
  const LiveCaseDetails({
    super.key,
    required this.caseNo,
  });

  @override
  State<LiveCaseDetails> createState() => _LiveCaseDetailsState();
}

class _LiveCaseDetailsState extends State<LiveCaseDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<CaseBloc>(context).add(
        GetCaseEvent(caseNo: widget.caseNo),
      ),
    );
  }

  void _listener(BuildContext context, CaseState state) {
    if (state is SuccessCaseState) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => CaseDetails(caseData: state.caseData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<CaseBloc>(context),
      listener: _listener,
      child: Scaffold(
        appBar: AppBarWidget(
          context: context,
          showBackArrow: true,
          title: 'Case: ${widget.caseNo}',
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CaseBloc, CaseState>(
      bloc: BlocProvider.of<CaseBloc>(context),
      builder: (context, state) {
        if (state is LoadingCaseState) {
          return const Loader();
        } else if (state is SuccessCaseState) {
          return const SizedBox.shrink();
        }
        return const Center(
          child: Text(
            'Something went wrong while fetching case!',
          ),
        );
      },
    );
  }
}
