import 'package:get_it/get_it.dart';

import 'local_storage_service.dart';

final locator = GetIt.instance;
Future<void> initializeLocator() async {
  locator.registerSingleton(
    LocalStorageService(),
  );
}
