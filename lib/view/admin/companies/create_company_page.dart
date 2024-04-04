import 'dart:developer';

import 'package:case_management/view/admin/bloc/admin_bloc.dart';
import 'package:case_management/view/admin/bloc/admin_events.dart';
import 'package:case_management/view/admin/bloc/admin_states.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/dropdown_fields.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/lawyers/get_all_lawyers_model.dart';
import '../../../utils/validator.dart';
import '../../../widgets/appbar_widget.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/text_widget.dart';

class CreateCompanyPage extends StatefulWidget {
  const CreateCompanyPage({super.key});

  @override
  State<CreateCompanyPage> createState() => _CreateCompanyPageState();
}

class _CreateCompanyPageState extends State<CreateCompanyPage> {
  final _companyNameController = TextEditingController();
  AllLawyer? _selectedLawyer;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<AdminBloc>(context).add(
        GetAdminsEvent(),
      ),
    );
  }

  set _onLawyerChanged(AllLawyer lawyer) {
    log('message: $lawyer');
    _selectedLawyer = lawyer;
  }

  void _onSubmitTap() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    BlocProvider.of<AdminBloc>(context).add(
      CreateCompanyEvent(
        companyName: _companyNameController.text,
        companyAdmin: _selectedLawyer,
      ),
    );
  }

  void _listener(BuildContext context, AdminState state) {
    if (state is ErrorAdminState) {
      CustomToast.show(state.message);
      BlocProvider.of<AdminBloc>(context).add(GetAdminsEvent());
    } else if (state is CreateCompanySuccessState) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<AdminBloc>(context),
      listener: _listener,
      child: Scaffold(
        appBar: AppBarWidget(
          context: context,
          title: 'Create New Company',
          showBackArrow: true,
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AdminBloc, AdminState>(
      bloc: BlocProvider.of<AdminBloc>(context),
      builder: (context, state) {
        if (state is LoadingAdminState) {
          return const Loader();
        } else if (state is ErrorAdminState) {
          return Center(
            child: textWidget(
              text: state.message,
            ),
          );
        } else if (state is GotAdminsState) {
          return _buildForm(state.lawyers);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildForm(List<AllLawyer> lawyers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _companyNameController,
              isWhiteBackground: true,
              label: 'Company Name',
              validatorCondition: Validator.notEmpty,
            ),
            const SizedBox(
              height: 10,
            ),
            if (lawyers.isNotEmpty)
              CustomTextFieldWithDropdown<AllLawyer>(
                isWhiteBackground: true,
                dropdownItems: lawyers,
                initialValue: _selectedLawyer,
                onDropdownChanged: (lawyer) {
                  _onLawyerChanged = lawyer;
                },
                hintText: 'Select Lawyer',
                builder: (lawyer) {
                  return textWidget(
                    text: lawyer.getDisplayName(),
                  );
                },
              ),
            const SizedBox(
              height: 20,
            ),
            RoundedElevatedButton(
              onPressed: _onSubmitTap,
              text: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
