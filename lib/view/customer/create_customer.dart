import 'package:case_management/view/customer/client_bloc/client_bloc.dart';
import 'package:case_management/view/customer/client_bloc/client_events.dart';
import 'package:case_management/view/customer/client_bloc/client_states.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/email_validator.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/toast.dart';

class CreateCustomer extends StatefulWidget {
  const CreateCustomer({
    super.key,
  });

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  TextEditingController cnicController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    cnicController.dispose();
    passController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Create Client',
      ),
      body: BlocListener(
        bloc: BlocProvider.of<ClientBloc>(context),
        listener: (context, state) {
          if (state is ErrorClientState) {
            CustomToast.show(state.message);
          } else if (state is SuccessClientState) {
            Navigator.pop(context);
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: cnicController,
                      textInputType: TextInputType.number,
                      isWhiteBackground: true,
                      hintText: 'Cnic',
                      validatorCondition: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your cnic.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: firstNameController,
                      textInputType: TextInputType.name,
                      isWhiteBackground: true,
                      hintText: 'FirstName',
                      validatorCondition: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: lastNameController,
                      textInputType: TextInputType.name,
                      isWhiteBackground: true,
                      hintText: 'LastName',
                      validatorCondition: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      isWhiteBackground: true,
                      hintText: 'Email',
                      validatorCondition: (String? input) =>
                          input!.trim().isValidEmail() ? null : "Invalid Email",
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      isWhiteBackground: true,
                      hintText: 'Phone Number',
                      validatorCondition: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: passController,
                      showPasswordHideButton: true,
                      isWhiteBackground: true,
                      hintText: 'Password',
                      maxLines: 1,
                      validatorCondition: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<ClientBloc, ClientState>(
                      bloc: BlocProvider.of<ClientBloc>(context),
                      builder: (context, state) {
                        if (state is LoadingClientState) {
                          return const Loader();
                        }
                        return RoundedElevatedButton(
                          text: 'Submit',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<ClientBloc>(context)
                                  .add(CreateClientEvent(
                                cnic: cnicController.text.trim(),
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                email: emailController.text.trim(),
                                phoneNumber: phoneController.text.trim(),
                                password: passController.text.trim(),
                              ));
                            }
                          },
                          borderRadius: 23,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
