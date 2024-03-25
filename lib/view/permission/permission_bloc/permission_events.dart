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
