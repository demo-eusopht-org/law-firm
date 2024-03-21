abstract class PermissionEvent {}

class GetRoleEvent extends PermissionEvent {}

class FetchRolesEvent extends PermissionEvent {
  final String permissionName;
  final List<int> roleIds;

  FetchRolesEvent(
    this.permissionName,
    this.roleIds,
  );
}
