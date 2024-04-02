import 'package:case_management/model/lawyers/get_all_lawyers_model.dart';
import 'package:case_management/model/lawyers/update_lawyer_response.dart';
import 'package:case_management/utils/constants.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_bloc.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_events.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_states.dart';
import 'package:case_management/view/lawyer/new_lawyer.dart';
import 'package:case_management/widgets/app_dialogs.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/rounded_image_view.dart';
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
  late AllLawyer lawyer;

  @override
  void initState() {
    lawyer = widget.lawyer;
    super.initState();
  }

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
                    final result = await Navigator.push<LawyerProfile>(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => NewLawyer(
                          lawyer: lawyer,
                        ),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        lawyer = result.toAllLawyer(
                          lawyer.cnic,
                          lawyer.profilePic,
                        );
                      });
                    }
                    BlocProvider.of<LawyerBloc>(context).add(
                      GetLawyersEvent(),
                    );
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
            Center(
              child: RoundNetworkImageView(
                url: Constants.getProfileUrl(lawyer.profilePic!, lawyer.id),
                size: 120,
              ),
            ),
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
            for (final qualification in lawyer.qualification)
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
            for (final exp in lawyer.experience) _buildExperience(exp),
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
            AppDialogs.showConfirmDialog(
              context: context,
              text: 'Are you sure you want to delete this lawyer?',
              onConfirm: () {
                BlocProvider.of<LawyerBloc>(context).add(
                  DeleteLawyerEvent(
                    cnic: lawyer.cnic,
                  ),
                );
                Navigator.pop(context);
              },
            );
          },
          icon: const Icon(
            Icons.delete,
          ),
          color: Colors.red,
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
                      text: lawyer.lawyerBio,
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
                    text: lawyer.lawyerCredentials,
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
                    text: lawyer.expertise,
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
                    text: lawyer.cnic,
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
                    text: lawyer.firstName,
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
                    text: lawyer.lastName,
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
                    text: lawyer.email,
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
