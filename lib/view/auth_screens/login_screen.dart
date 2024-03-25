import 'dart:ui';

import 'package:case_management/utils/validator.dart';
import 'package:case_management/view/auth_screens/auth_bloc/auth_states.dart';
import 'package:case_management/view/auth_screens/forgot_password.dart';
import 'package:case_management/widgets/bottom_navigation.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_assets.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_textfield.dart';
import 'auth_bloc/auth_bloc.dart';
import 'auth_bloc/auth_eventes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController cnicController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    cnicController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: BlocProvider.of<AuthBloc>(context),
        listener: (context, state) {
          if (state is ErrorAuthState) {
            CustomToast.show(state.message);
          } else if (state is SuccessAuthState) {
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                builder: (context) => const MainScreen(),
              ),
              (_) => false,
            );
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppAssets.loginBacground,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Icon(
                            Icons.person,
                            size: 45,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          controller: cnicController,
                          isWhiteBackground: false,
                          label: 'CNIC',
                          validatorCondition: Validator.cnic,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: passController,
                          isWhiteBackground: false,
                          showPasswordHideButton: true,
                          label: 'Password',
                          maxLines: 1,
                          validatorCondition: Validator.password,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.mulish(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<AuthBloc, AuthState>(
                          bloc: BlocProvider.of<AuthBloc>(context),
                          builder: (context, state) {
                            if (state is LoadingAuthState) {
                              return const Loader();
                            }
                            return RoundedElevatedButton(
                              text: 'Login',
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  LoginEvent(
                                    cnic: cnicController.text.trim(),
                                    password: passController.text.trim(),
                                  ),
                                );
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
          ],
        ),
      ),
    );
  }
}
