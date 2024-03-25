import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/permission/get_role_model.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/toast.dart';
import 'permission_bloc/permission_bloc.dart';
import 'permission_bloc/permission_events.dart';
import 'permission_bloc/permission_state.dart';

class CreatePermissionScreen extends StatefulWidget {
  const CreatePermissionScreen({super.key});

  @override
  State<CreatePermissionScreen> createState() => _CreatePermissionScreenState();
}

class _CreatePermissionScreenState extends State<CreatePermissionScreen> {
  final _rolesNotifier = ValueNotifier<List<Role>>([]);
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<PermissionBloc>(context).add(
        GetRoleEvent(),
      ),
    );
  }

  void _listener(context, state) {
    if (state is ErrorPermissionState) {
      CustomToast.show(state.message);
    } else if (state is CreatePermissionState) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _rolesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<PermissionBloc>(context),
      listener: _listener,
      child: Scaffold(
        appBar: AppBarWidget(
          context: context,
          showBackArrow: true,
          title: 'Add Role',
        ),
        body: BlocBuilder<PermissionBloc, PermissionState>(
          bloc: BlocProvider.of<PermissionBloc>(context),
          builder: (context, state) {
            if (state is LoadingPermissionState) {
              return const Loader();
            } else if (state is SuccessRolesState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: buildRolefield(state),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget buildRolefield(SuccessRolesState state) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            controller: nameController,
            hintText: 'Name',
            isWhiteBackground: true,
            validatorCondition: (value) {
              if (value!.isEmpty) {
                return 'Please enter permission name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ValueListenableBuilder(
            valueListenable: _rolesNotifier,
            builder: (context, roles, child) {
              return Column(
                children: state.roles.map(
                  (role) {
                    return _buildCheckBoxRow(
                      role,
                      roles.contains(role),
                    );
                  },
                ).toList(),
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
          RoundedElevatedButton(
            onPressed: () async {
              try {
                if (_rolesNotifier.value.isEmpty) {
                  CustomToast.show('Please select at least one role!');
                  return;
                }
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<PermissionBloc>(context).add(
                    CreatePermissionEvent(
                      nameController.text.trim(),
                      _rolesNotifier.value.map((role) {
                        return role.id;
                      }).toList(),
                    ),
                  );
                }
              } catch (error) {
                CustomToast.show('An error occurred');
              }
            },
            text: 'Submit',
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBoxRow(Role role, bool isSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textWidget(text: role.roleName),
        Checkbox(
          value: isSelected,
          onChanged: (newValue) {
            final temp = List.of(_rolesNotifier.value);
            if (newValue ?? false) {
              temp.add(role);
            } else {
              temp.remove(role);
            }
            _rolesNotifier.value = temp;
          },
        ),
      ],
    );
  }
}
