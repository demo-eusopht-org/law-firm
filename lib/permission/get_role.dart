import 'package:case_management/permission/permission_bloc/permission_bloc.dart';
import 'package:case_management/permission/permission_bloc/permission_events.dart';
import 'package:case_management/permission/permission_bloc/permission_state.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/toast.dart';

class GetRole extends StatefulWidget {
  const GetRole({super.key});

  @override
  State<GetRole> createState() => _GetRoleState();
}

class _GetRoleState extends State<GetRole> {
  final ValueNotifier<bool> isLawyerSelected = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isClientSelected = ValueNotifier<bool>(false);

  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> isLOading = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<PermissionBloc>(context).add(
        GetRoleEvent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Add Role',
      ),
      body: BlocBuilder<PermissionBloc, PermissionState>(
        bloc: BlocProvider.of<PermissionBloc>(context),
        builder: (context, state) {
          print('hello${state.runtimeType}');
          if (state is LoadingPermissionState) {
            return const Loader();
          } else if (state is SuccessPermissionState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: buildRolefield(state),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget buildRolefield(SuccessPermissionState state) {
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
          SizedBox(
            height: 10,
          ),
          buildCheckBoxRow(
            state.roles[0].roleName,
            isLawyerSelected,
          ),
          buildCheckBoxRow(
            state.roles[1].roleName,
            isClientSelected,
          ),
          SizedBox(
            height: 30,
          ),
          ValueListenableBuilder(
            valueListenable: isLOading,
            builder: (context, loading, child) {
              if (loading) {
                return const Loader();
              }
              return BlocListener<PermissionBloc, PermissionState>(
                listener: (context, state) {
                  if (state is ErrorPermissionState) {
                    CustomToast.show(state.message);
                  } else if (state is SuccessPermissionState) {
                    Navigator.pop(context);
                  }
                },
                child: RoundedElevatedButton(
                  onPressed: () async {
                    try {
                      if (_formKey.currentState!.validate()) {
                        isLOading.value = true;
                        List<int> selectedRoleIds = [];
                        if (isLawyerSelected.value) {
                          selectedRoleIds.add(state.roles[0].id);
                        }
                        if (isClientSelected.value) {
                          selectedRoleIds.add(state.roles[1].id);
                        }
                        BlocProvider.of<PermissionBloc>(context).add(
                          FetchRolesEvent(
                            nameController.text.trim(),
                            selectedRoleIds,
                          ),
                        );
                      }
                    } catch (error) {
                      print('Error: $error');
                      CustomToast.show('An error occurred');

                      isLOading.value = false;
                    }
                  },
                  text: 'Submit',
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildCheckBoxRow(String text, ValueNotifier<bool> valueNotifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textWidget(text: text),
        ValueListenableBuilder<bool>(
          valueListenable: valueNotifier,
          builder: (context, value, child) {
            return Checkbox(
              value: value,
              onChanged: (newValue) {
                print(newValue);
                valueNotifier.value = newValue ?? false;
              },
            );
          },
        ),
      ],
    );
  }
}
