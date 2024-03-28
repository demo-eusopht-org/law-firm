import 'package:case_management/utils/validator.dart';
import 'package:case_management/view/auth_screens/auth_bloc/auth_bloc.dart';
import 'package:case_management/view/auth_screens/auth_bloc/auth_eventes.dart';
import 'package:case_management/view/auth_screens/auth_bloc/auth_states.dart';
import 'package:case_management/view/auth_screens/login_screen.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/button_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController cnicController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    cnicController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Forgot Password',
      ),
      body: BlocListener(
        bloc: BlocProvider.of<AuthBloc>(context),
        listener: (context, state) {
          if (state is ErrorAuthState) {
            CustomToast.show(state.message);
          } else if (state is ForgotSuccessAuthState) {
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (_) => false,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: cnicController,
                  isWhiteBackground: true,
                  label: 'CNIC',
                  validatorCondition: Validator.cnic,
                ),
                const SizedBox(height: 20),
                BlocBuilder(
                    bloc: BlocProvider.of<AuthBloc>(context),
                    builder: (context, state) {
                      if (state is LoadingAuthState) {
                        return const CircularProgressIndicator(
                          color: Colors.green,
                        );
                      }
                      return RoundedElevatedButton(
                        text: 'Submit',
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            ForgotEvent(
                              cnic: cnicController.text.trim(),
                            ),
                          );
                        },
                        borderRadius: 23,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
