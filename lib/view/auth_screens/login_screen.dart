import 'dart:ui';

import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_assets.dart';
import '../../utils/validator.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader.dart';
import '../../widgets/toast.dart';
import 'auth_bloc/auth_bloc.dart';
import 'auth_bloc/auth_eventes.dart';
import 'auth_bloc/auth_states.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
                        Image.asset(
                          'assets/app_icon.png',
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        textWidget(
                          text: 'LOGIN',
                          color: Colors.white,
                          fSize: 35,
                          letterSpacing: 10,
                          fWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          controller: cnicController,
                          isWhiteBackground: false,
                          label: 'CNIC',
                          labelColor: Colors.white,
                          textInputType: TextInputType.number,
                          validatorCondition: Validator.cnic,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: passController,
                          isWhiteBackground: false,
                          showPasswordHideButton: true,
                          label: 'Password',
                          labelColor: Colors.white,
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
