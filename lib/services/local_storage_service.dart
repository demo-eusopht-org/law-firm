import 'package:hive/hive.dart';

class LocalStorageService {
  late Box<String> _box;

  Future<void> initializeBox() async {
    _box = await Hive.openBox<String>('law-firm');
  }

  Future<void> clearAll() async {
    await _box.clear();
  }

  Future<void> saveData(String key, String value) async {
    await _box.put(key, value);
  }

  String? getData(String key) {
    return _box.get(key);
  }
}
