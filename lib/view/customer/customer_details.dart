import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/cases/case_details.dart';
import 'package:case_management/view/customer/client_bloc/client_bloc.dart';
import 'package:case_management/view/customer/client_bloc/client_events.dart';
import 'package:case_management/view/customer/client_bloc/client_states.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/rounded_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/cases/all_cases_response.dart';
import '../../model/lawyers/all_clients_response.dart';
import '../../utils/constants.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/text_widget.dart';

class CustomerDetails extends StatefulWidget {
  final Client user;

  const CustomerDetails({
    super.key,
    required this.user,
  });

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<ClientBloc>(context).add(
        GetClientCasesEvent(clientId: widget.user.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Client Details',
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          RoundImageView(
            url: Constants.getProfileUrl(
              widget.user.profilePic,
              widget.user.id,
            ),
            size: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'Personal Details',
            ),
          ),
          _buildClientCard(),
          BlocBuilder<ClientBloc, ClientState>(
            bloc: BlocProvider.of<ClientBloc>(context),
            builder: (context, state) {
              if (state is LoadingClientState) {
                return const Loader();
              } else if (state is ErrorClientState) {
                return Center(
                  child: textWidget(text: state.message),
                );
              } else if (state is SuccessClientCasesState) {
                return _buildCases(state.cases);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCases(List<Case> cases) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        _buildExpanded(cases),
      ],
    );
  }

  Widget _buildExpanded(List<Case> cases) {
    if (cases.isEmpty) {
      return Center(
        child: textWidget(
          text: 'No cases found for this user!',
        ),
      );
    }
    final activeCases = cases.where((caseData) {
      return caseData.caseStatus == 'Pending';
    }).toList();
    final inactiveCases = cases.where((caseData) {
      return caseData.caseStatus == 'Adjourned';
    }).toList();
    return Column(
      children: [
        if (activeCases.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'Active Cases',
            ),
          ),
        ...activeCases.map((caseData) {
          return _buildLCaseCard(caseData);
        }),
        if (inactiveCases.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'Inactive Cases',
            ),
          ),
        ...inactiveCases.map((caseData) {
          return _buildLCaseCard(caseData);
        }),
      ],
    );
  }

  Widget _buildClientCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRowItem(
                label: 'CNIC',
                value: widget.user.cnic,
              ),
              _buildRowItem(
                label: 'First Name',
                value: widget.user.firstName,
              ),
              _buildRowItem(
                label: 'Last Name',
                value: widget.user.lastName,
              ),
              _buildRowItem(
                label: 'Email',
                value: widget.user.email,
              ),
              _buildRowItem(
                label: 'Phone Number',
                value: widget.user.phoneNumber,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowItem({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget(
            text: label,
            fSize: 14.0,
          ),
          textWidget(
            text: value,
            fSize: 14.0,
          ),
        ],
      ),
    );
  }

  Widget _buildLCaseCard(Case caseData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: ListTile(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CaseDetails(caseData: caseData),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    text: 'Case No:',
                    fSize: 14.0,
                    fWeight: FontWeight.w500,
                  ),
                  textWidget(
                    text: caseData.caseNo,
                    fSize: 14.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    text: 'Next Hearing Date:',
                    fSize: 14.0,
                    fWeight: FontWeight.w500,
                  ),
                  textWidget(
                    text: caseData.nextHearingDate.getFormattedDate(),
                    fSize: 14.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    text: 'Status:',
                    fSize: 14.0,
                    fWeight: FontWeight.w500,
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
      ),
    );
  }
}
