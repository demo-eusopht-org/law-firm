import 'package:case_management/services/image_picker_service.dart';
import 'package:get_it/get_it.dart';

import 'local_storage_service.dart';

final locator = GetIt.instance;
Future<void> initializeLocator() async {
  locator
    ..registerSingleton(LocalStorageService())
    ..registerSingleton(ImagePickerService());
}
