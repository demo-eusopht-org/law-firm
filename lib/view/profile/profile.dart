import 'package:case_management/services/image_picker_service.dart';
import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/view/profile/profile_bloc/profile_bloc.dart';
import 'package:case_management/view/profile/profile_bloc/profile_events.dart';
import 'package:case_management/view/profile/profile_bloc/profile_states.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/lawyers/profile_response.dart';
import '../../utils/constants.dart';
import '../auth_screens/login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _cnicController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();
  final _phoneController = TextEditingController();
  final _credentialsController = TextEditingController();
  final _expertiseController = TextEditingController();
  final _lawyerBioController = TextEditingController();

  void _listener(BuildContext context, ProfileState state) async {
    if (state is GotProfileState) {
      final profile = state.profile;
      _cnicController.text = profile.cnic;
      _firstNameController.text = profile.firstName;
      _lastNameController.text = profile.lastName ?? '';
      _emailController.text = profile.email;
      _roleController.text = profile.roleName;
      _phoneController.text = profile.phoneNumber;
      _credentialsController.text = profile.lawyerCredentials ?? '';
      _expertiseController.text = profile.expertise ?? '';
      _lawyerBioController.text = profile.lawyerBio ?? '';
    } else if (state is LogoutProfileState) {
      await locator<LocalStorageService>().clearAll();
      configNotifier.value = [];
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (_) => false,
      );
    }
  }

  Future<void> _changeProfileImage() async {
    final image = await locator<ImagePickerService>().pickImage(
      ImageSource.gallery,
    );
    if (image != null) {
      BlocProvider.of<ProfileBloc>(context).add(
        ChangeProfileImageEvent(image: image),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<ProfileBloc>(context).add(
        GetProfileEvent(),
      ),
    );
  }

  @override
  void dispose() {
    _cnicController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    _phoneController.dispose();
    _credentialsController.dispose();
    _expertiseController.dispose();
    _lawyerBioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<ProfileBloc>(context),
      listener: _listener,
      child: Scaffold(
        appBar: AppBarWidget(
          context: context,
          showBackArrow: true,
          title: 'Profile',
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: BlocProvider.of<ProfileBloc>(context),
      builder: (context, state) {
        if (state is LoadingProfileState) {
          return const Loader();
        } else if (state is GotProfileState) {
          return _buildProfile(state.profile, state.imageUploadLoading);
        }
        return Center(
          child: textWidget(
            text: 'Something went wrong while fetching profile!',
          ),
        );
      },
    );
  }

  Widget _buildProfile(Profile profile, bool imageUploadLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          Expanded(
            child: _buildForm(profile, imageUploadLoading),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: RoundedElevatedButton(
              borderRadius: 23,
              onPressed: () async {
                BlocProvider.of<ProfileBloc>(context).add(
                  LogoutProfileEvent(),
                );
              },
              text: 'Logout',
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForm(Profile profile, bool imageUploadLoading) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          _buildProfileImage(profile.profilePic, imageUploadLoading),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: _cnicController,
            readonly: true,
            label: 'CNIC',
            isWhiteBackground: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: _firstNameController,
            readonly: true,
            label: 'First Name',
            isWhiteBackground: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: _lastNameController,
            readonly: true,
            label: 'Last Name',
            isWhiteBackground: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: _emailController,
            readonly: true,
            label: 'Email',
            isWhiteBackground: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: _roleController,
            readonly: true,
            label: 'Role',
            isWhiteBackground: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: _phoneController,
            readonly: true,
            label: 'Phone Number',
            isWhiteBackground: true,
          ),
          const SizedBox(
            height: 20,
          ),
          if (profile.roleName == 'LAWYER') _buildLawyerProfile(),
        ],
      ),
    );
  }

  Widget _buildProfileImage(String? profilePic, bool imageUploadLoading) {
    if (profilePic == null) {
      return const SizedBox.shrink();
    }
    final userId = locator<LocalStorageService>().getData('id');
    return Stack(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: profilePic == ""
              ? const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 60,
                )
              : Image.network(
                  Constants.getProfileUrl(profilePic, userId),
                  fit: BoxFit.fitWidth,
                  height: 100,
                  width: 100,
                ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: imageUploadLoading
              ? const Loader()
              : GestureDetector(
                  onTap: _changeProfileImage,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade900,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildLawyerProfile() {
    return Column(
      children: [
        CustomTextField(
          controller: _credentialsController,
          readonly: true,
          label: 'Lawyer Credentials',
          isWhiteBackground: true,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          controller: _expertiseController,
          readonly: true,
          label: 'Expertise',
          isWhiteBackground: true,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          controller: _lawyerBioController,
          readonly: true,
          label: 'Lawyer Bio',
          maxLines: 3,
          isWhiteBackground: true,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
