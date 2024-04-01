import 'package:case_management/view/permission/permission_bloc/permission_state.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/permission/all_permissions_response.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/text_widget.dart';
import 'create_permission_screen.dart';
import 'permission_bloc/permission_bloc.dart';
import 'permission_bloc/permission_events.dart';

class RolePermission extends StatefulWidget {
  const RolePermission({super.key});

  @override
  State<RolePermission> createState() => _RolePermissionState();
}

class _RolePermissionState extends State<RolePermission> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<PermissionBloc>(context).add(
        GetAllPermissionsEvent(),
      ),
    );
  }

  void _onChangePermission(
    AppPermission permission,
    RoleEnabled role,
    bool enabled,
  ) {
    BlocProvider.of<PermissionBloc>(context).add(
      ChangePermissionEvent(
        permissionId: permission.id,
        roleId: role.id,
        enabled: enabled,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: SizedBox(
        width: size.width * 0.5,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: Colors.green,
          child: textWidget(
            text: 'Create a Permission',
            color: Colors.white,
            fSize: 16.0,
            fWeight: FontWeight.w700,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const CreatePermissionScreen(),
              ),
            );
            BlocProvider.of<PermissionBloc>(context).add(
              GetAllPermissionsEvent(),
            );
          },
        ),
      ),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Roles and Permission',
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PermissionBloc, PermissionState>(
      bloc: BlocProvider.of<PermissionBloc>(context),
      builder: (context, state) {
        if (state is LoadingPermissionState) {
          return const Loader();
        } else if (state is SuccessAllPermissionState) {
          return _buildPermissionList(state.permissions);
        } else if (state is ErrorPermissionState) {
          return Center(
            child: textWidget(text: state.message),
          );
        }
        return Center(
          child: textWidget(
            text: 'Something went wrong, please try again!',
          ),
        );
      },
    );
  }

  Widget _buildPermissionList(List<AppPermission> permissions) {
    if (permissions.isEmpty) {
      return Center(
        child: textWidget(text: 'No permissions found!'),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 40),
        itemCount: permissions.length,
        itemBuilder: (context, index) {
          final permission = permissions[index];
          return _buildExpansionTile(permission);
        },
      ),
    );
  }

  Widget _buildExpansionTile(AppPermission permission) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ExpansionTile(
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        collapsedBackgroundColor: Colors.green,
        iconColor: Colors.green,
        title: textWidget(
          text: permission.permission,
          fSize: 18.0,
          fWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        children: permission.roles.map((role) {
          return _buildPermissionRole(permission, role);
        }).toList(),
      ),
    );
  }

  Widget _buildPermissionRole(AppPermission permission, RoleEnabled role) {
    return ListTile(
      title: textWidget(
        text: role.roleName,
        fSize: 16.0,
        color: Colors.black87,
      ),
      trailing: Switch.adaptive(
        activeTrackColor: Colors.green[200],
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.white,
        value: role.enabled,
        onChanged: (value) => _onChangePermission(
          permission,
          role,
          value,
        ),
      ),
    );
  }
}
