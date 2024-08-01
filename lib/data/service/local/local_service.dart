import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalService {
  Future<void> write(String key, dynamic value);
  Future<dynamic> read(String key);
  Future<void> remove(String key);
  Future<void> clear();
}

class LocalServiceImpl implements LocalService {
  @override
  Future<void> write(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  @override
  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.get(key);

    if (data is List<dynamic>) {
      return data.cast<String>();
    }
    return data;
  }

  @override
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
