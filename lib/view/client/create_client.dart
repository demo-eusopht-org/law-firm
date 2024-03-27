import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/lawyers/all_clients_response.dart';
import '../../services/image_picker_service.dart';
import '../../services/locator.dart';
import '../../utils/constants.dart';
import '../../utils/validator.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader.dart';
import '../../widgets/round_file_image_view.dart';
import '../../widgets/rounded_image_view.dart';
import '../../widgets/toast.dart';
import 'client_bloc/client_bloc.dart';
import 'client_bloc/client_events.dart';
import 'client_bloc/client_states.dart';

class CreateCustomer extends StatefulWidget {
  final Client? client;
  const CreateCustomer({
    super.key,
    this.client,
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
  final _selectedFilesNotifier = ValueNotifier<XFile?>(null);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cnicController.text = widget.client?.cnic ?? '';
    firstNameController.text = widget.client?.firstName ?? '';
    lastNameController.text = widget.client?.lastName ?? '';
    emailController.text = widget.client?.email ?? '';
    phoneController.text = widget.client?.phoneNumber ?? '';
  }

  void _onSubmitPressed() {
    if (_formKey.currentState!.validate()) {
      final bloc = BlocProvider.of<ClientBloc>(context);
      final cnic = cnicController.text.trim();
      final firstName = firstNameController.text.trim();
      final lastName = lastNameController.text.trim();
      final email = emailController.text.trim();
      final phoneNumber = phoneController.text.trim();
      if (widget.client == null) {
        bloc.add(
          CreateClientEvent(
            cnic: cnic,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            password: passController.text.trim(),
            profileImage: _selectedFilesNotifier.value,
          ),
        );
      } else {
        bloc.add(
          UpdateClientEvent(
            clientId: widget.client!.id,
            cnic: cnic,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            profileImage: _selectedFilesNotifier.value,
          ),
        );
      }
    }
  }

  Future<void> _onImageTapped() async {
    try {
      final image = await locator<ImagePickerService>().pickImage(
        ImageSource.gallery,
      );
      _selectedFilesNotifier.value = image;
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    cnicController.dispose();
    passController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    _selectedFilesNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: widget.client != null ? 'Update Client' : 'Create Client',
      ),
      body: BlocListener(
        bloc: BlocProvider.of<ClientBloc>(context),
        listener: (context, state) {
          if (state is ErrorClientState) {
            CustomToast.show(state.message);
          } else if (state is SuccessClientState) {
            Navigator.pop<bool>(context, true);
          }
        },
        child: _buildBody(context),
      ),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGap(),
              _buildProfileImage(),
              _buildGap(),
              CustomTextField(
                controller: cnicController,
                textInputType: TextInputType.number,
                isWhiteBackground: true,
                label: 'CNIC',
                enabled: widget.client == null,
                validatorCondition: Validator.cnic,
              ),
              _buildGap(),
              CustomTextField(
                controller: firstNameController,
                textInputType: TextInputType.name,
                isWhiteBackground: true,
                label: 'First Name',
                validatorCondition: Validator.notEmpty,
              ),
              _buildGap(),
              CustomTextField(
                controller: lastNameController,
                textInputType: TextInputType.name,
                isWhiteBackground: true,
                label: 'Last Name',
                validatorCondition: Validator.notEmpty,
              ),
              _buildGap(),
              CustomTextField(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                isWhiteBackground: true,
                label: 'Email',
                validatorCondition: Validator.email,
              ),
              _buildGap(),
              CustomTextField(
                controller: phoneController,
                textInputType: TextInputType.phone,
                isWhiteBackground: true,
                label: 'Phone Number',
                validatorCondition: Validator.phoneNumber,
              ),
              _buildGap(),
              if (widget.client == null)
                CustomTextField(
                  controller: passController,
                  showPasswordHideButton: true,
                  isWhiteBackground: true,
                  label: 'Password',
                  maxLines: 1,
                  validatorCondition: Validator.password,
                ),
              if (widget.client == null) _buildGap(),
              BlocBuilder<ClientBloc, ClientState>(
                bloc: BlocProvider.of<ClientBloc>(context),
                builder: (context, state) {
                  if (state is LoadingClientState) {
                    return const Loader();
                  }
                  return RoundedElevatedButton(
                    text: widget.client != null ? 'Update' : 'Submit',
                    onPressed: _onSubmitPressed,
                    borderRadius: 23,
                  );
                },
              ),
              _buildGap(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildGap() => const SizedBox(height: 20);

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _onImageTapped,
      child: ValueListenableBuilder(
        valueListenable: _selectedFilesNotifier,
        builder: (context, file, child) {
          final showOnlineImage =
              (widget.client?.profilePic.isNotEmpty ?? false) && file == null;
          log('FILE: ${file?.path}');
          if (showOnlineImage) {
            return RoundNetworkImageView(
              url: Constants.getProfileUrl(
                widget.client!.profilePic,
                widget.client!.id,
              ),
              showBadge: true,
              size: 120,
            );
          } else if (file != null) {
            return RoundFileImageView(
              filePath: file.path,
              size: 120,
              showBadge: true,
            );
          }
          return const CircleAvatar(
            backgroundColor: Colors.green,
            radius: 60,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
