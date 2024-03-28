import 'package:case_management/model/lawyers/get_all_lawyers_model.dart';
import 'package:case_management/utils/constants.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_bloc.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_events.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_states.dart';
import 'package:case_management/view/lawyer/new_lawyer.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/text_widget.dart';

class LawyerDetails extends StatefulWidget {
  final AllLawyer lawyer;
  const LawyerDetails({
    super.key,
    required this.lawyer,
  });

  @override
  State<LawyerDetails> createState() => _LawyerDetailsState();
}

class _LawyerDetailsState extends State<LawyerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Lawyer Details',
        action: [
          Row(
            children: [
              if (configNotifier.value.contains(Constants.updateLawyer))
                IconButton(
                  onPressed: () async {
                    final result = await Navigator.pushReplacement<bool, void>(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => NewLawyer(
                          lawyer: widget.lawyer,
                        ),
                      ),
                    );
                    if (result ?? false) {
                      BlocProvider.of<LawyerBloc>(context).add(
                        GetLawyersEvent(),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                  color: Colors.white,
                ),
              if (configNotifier.value.contains(Constants.deleteLawyer))
                _buildDeleteIcon(),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: textWidget(text: 'Personal Details'),
            ),
            _buildPersonalDetails(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: textWidget(text: 'Lawyer Info'),
            ),
            _buildLawyerInfo(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: textWidget(text: 'Qualification'),
            ),
            for (final qualification in widget.lawyer.qualification)
              _buildQualification(qualification),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: textWidget(
                text: 'Working History',
              ),
            ),
            for (final exp in widget.lawyer.experience) _buildExperience(exp),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteIcon() {
    return BlocBuilder<LawyerBloc, LawyerState>(
      bloc: BlocProvider.of<LawyerBloc>(context),
      builder: (context, state) {
        if (state is LoadingLawyerState) {
          return const Loader();
        }
        return IconButton(
          onPressed: () {
            BlocProvider.of<LawyerBloc>(context).add(
              DeleteLawyerEvent(
                cnic: widget.lawyer.cnic,
              ),
            );
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.delete,
          ),
          color: Colors.white,
        );
      },
    );
  }

  Padding _buildExperience(AllLawyerExp exp) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Job Title'),
                  textWidget(
                    text: exp.jobTitle,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Employer'),
                  textWidget(
                    text: exp.employer,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Start Date:'),
                  textWidget(
                    text: exp.startYear,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'End Date:'),
                  textWidget(text: exp.endYear),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildQualification(AllLawyerQualification qualification) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Degree:'),
                  textWidget(
                    text: qualification.degree,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Institute'),
                  textWidget(
                    text: qualification.institute,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Start Date:'),
                  textWidget(
                    text: qualification.startYear,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'End Date:'),
                  textWidget(
                    text: qualification.endYear,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildLawyerInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Lawyer Bio:'),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: textWidget(
                      text: widget.lawyer.lawyerBio,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Lawyer Credential:'),
                  textWidget(
                    text: widget.lawyer.lawyerCredentials,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Expertise:'),
                  textWidget(
                    text: widget.lawyer.expertise,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildPersonalDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    text: 'CNIC:',
                  ),
                  textWidget(
                    text: widget.lawyer.cnic,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    text: 'First Name:',
                  ),
                  textWidget(
                    text: widget.lawyer.firstName,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Last Name:'),
                  textWidget(
                    text: widget.lawyer.lastName,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Email:'),
                  textWidget(
                    text: widget.lawyer.email,
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
