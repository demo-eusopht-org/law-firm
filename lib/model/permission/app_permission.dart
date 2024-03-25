class AppPermission {
  final bool createLawyer;
  final bool deleteLawyer;
  final bool updateLawyer;
  final bool createClient;
  final bool updateClient;
  final bool createCase;

  AppPermission({
    required this.createLawyer,
    required this.deleteLawyer,
    required this.updateLawyer,
    required this.createClient,
    required this.updateClient,
    required this.createCase,
  });

  AppPermission copyWith({
    bool? createLawyer,
    bool? deleteLawyer,
    bool? updateLawyer,
    bool? createClient,
    bool? updateClient,
    bool? createCase,
  }) {
    return AppPermission(
      createLawyer: createLawyer ?? this.createLawyer,
      deleteLawyer: deleteLawyer ?? this.deleteLawyer,
      updateLawyer: updateLawyer ?? this.updateLawyer,
      createClient: createClient ?? this.createClient,
      updateClient: updateClient ?? this.updateClient,
      createCase: createCase ?? this.createCase,
    );
  }
}
