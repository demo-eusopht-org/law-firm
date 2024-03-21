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

class GetRole extends StatefulWidget {
  const GetRole({super.key});

  @override
  State<GetRole> createState() => _GetRoleState();
}

class _GetRoleState extends State<GetRole> {
  final ValueNotifier<bool> isLawyerSelected = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isClientSelected = ValueNotifier<bool>(false);

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
          hintText: 'Name',
          isWhiteBackground: true,
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
        RoundedElevatedButton(
          onPressed: () {},
          text: 'Submit',
        )
      ],
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
