import 'package:case_management/model/get_all_lawyers_model.dart';
import 'package:case_management/view/lawyer/new_lawyer.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              IconButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => NewLawyer(
                      lawyer: widget.lawyer,
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.edit,
                ),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                ),
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: textWidget(text: 'Personal Details'),
            ),
            _buildPersonalDetails(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: textWidget(text: 'Lawyer Info'),
            ),
            _buildLawyerInfo(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: textWidget(text: 'Qualification'),
            ),
            for (final qualification in widget.lawyer.qualification)
              _buildQualification(qualification),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: textWidget(
                text: 'Working History',
              ),
            ),
            for (final exp in widget.lawyer.experience) _buildExperience(exp),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
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
                    text: exp.jobTitle!,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Employer'),
                  textWidget(
                    text: exp.employer!,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Start Date:'),
                  textWidget(
                    text: '${exp.startYear!}',
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'End Date:'),
                  textWidget(text: '${exp.endYear!}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildQualification(AlllawyerQualification qualification) {
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
                    text: qualification.degree!,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Institute'),
                  textWidget(
                    text: qualification.institute!,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Start Date:'),
                  textWidget(
                    text: '${qualification.startYear!}',
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'End Date:'),
                  textWidget(
                    text: '${qualification.endYear!}',
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
                  textWidget(
                    text: widget.lawyer.lawyerBio!,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Lawyer Credential:'),
                  textWidget(
                    text: widget.lawyer.lawyerCredentials!,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Expertise:'),
                  textWidget(
                    text: widget.lawyer.expertise!,
                  ),
                ],
              ),
              SizedBox(
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
                    text: widget.lawyer.cnic!,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    text: 'First Name:',
                  ),
                  textWidget(
                    text: widget.lawyer.firstName!,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Last Name:'),
                  textWidget(
                    text: widget.lawyer.lastName!,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Email:'),
                  textWidget(
                    text: widget.lawyer.email!,
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
