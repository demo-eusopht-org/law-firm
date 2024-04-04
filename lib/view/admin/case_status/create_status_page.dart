import 'package:case_management/utils/validator.dart';
import 'package:case_management/view/admin/bloc/admin_bloc.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/cases/case_status.dart';
import '../../../widgets/appbar_widget.dart';
import '../bloc/admin_events.dart';

class CreateStatusPage extends StatefulWidget {
  final CaseStatus? status;
  const CreateStatusPage({
    super.key,
    this.status,
  });

  @override
  State<CreateStatusPage> createState() => _CreateStatusPageState();
}

class _CreateStatusPageState extends State<CreateStatusPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.status != null) {
      _controller.text = widget.status?.statusName ?? '';
    }
  }

  void _onSubmitTap() {
    if (_formKey.currentState!.validate()) {
      final adminBloc = BlocProvider.of<AdminBloc>(context);
      if (widget.status != null) {
        adminBloc.add(
          UpdateStatusAdminEvent(
            statusName: _controller.text,
            statusId: widget.status!.id,
          ),
        );
      } else {
        adminBloc.add(
          CreateStatusAdminEvent(
            statusName: _controller.text,
          ),
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.status != null ? 'Update Status' : 'Create New Status',
        showBackArrow: true,
        context: context,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _controller,
              isWhiteBackground: true,
              label: 'Status Name',
              textInputType: TextInputType.text,
              validatorCondition: Validator.notEmpty,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedElevatedButton(
              onPressed: _onSubmitTap,
              text: widget.status != null ? 'Update' : 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
