abstract class PermissionEvent {}

class GetRoleEvent extends PermissionEvent {}

class CreatePermissionEvent extends PermissionEvent {
  final String permissionName;
  final List<int> roleIds;

  CreatePermissionEvent(
    this.permissionName,
    this.roleIds,
  );
}

class GetAllPermissionsEvent extends PermissionEvent {}

class ChangePermissionEvent extends PermissionEvent {
  final int permissionId;
  final int roleId;
  final bool enabled;

  ChangePermissionEvent({
    required this.permissionId,
    required this.roleId,
    required this.enabled,
  });
}

class GetConfigPermissionEvent extends PermissionEvent {}
