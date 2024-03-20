import 'package:case_management/view/profile/profile_bloc/profile_bloc.dart';
import 'package:case_management/view/profile/profile_bloc/profile_events.dart';
import 'package:case_management/view/profile/profile_bloc/profile_states.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/local_storage_service.dart';
import '../../services/locator.dart';
import '../../widgets/toast.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController confirmController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  String? cnic = locator<LocalStorageService>().getData('cnic');
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    confirmController.dispose();
    newPassController.dispose();
    oldPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Change Password',
      ),
      body: BlocListener(
        bloc: BlocProvider.of<ProfileBloc>(context),
        listener: (context, state) {
          if (state is ErrorProfileState) {
            CustomToast.show(state.message);
          } else if (state is SuccessProfileState) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: oldPassController,
                  maxLines: 1,
                  hintText: 'Old password',
                  isWhiteBackground: true,
                  showPasswordHideButton: true,
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your old password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: newPassController,
                  maxLines: 1,
                  hintText: 'New password',
                  isWhiteBackground: true,
                  showPasswordHideButton: true,
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your new password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: confirmController,
                  maxLines: 1,
                  hintText: 'Confirm password',
                  isWhiteBackground: true,
                  showPasswordHideButton: true,
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter confirm password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  bloc: BlocProvider.of<ProfileBloc>(context),
                  builder: (context, state) {
                    if (state is LoadingProfileState) {
                      return const Loader();
                    }
                    return RoundedElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<ProfileBloc>(context).add(
                            UpdatePasswordEvent(
                              oldPassword: oldPassController.text.trim(),
                              newPassword: newPassController.text.trim(),
                              cnic: cnic ?? '',
                            ),
                          );
                        }
                      },
                      text: 'Confirm',
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
