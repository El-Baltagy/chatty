import 'package:shared_preferences/shared_preferences.dart';

abstract class CachHelper {
  static SharedPreferences? prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

class SaveDataToPrefs extends CachHelper {
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) {
      return await CachHelper.prefs!.setInt(key, value);
    }
    if (value is String) {
      return await CachHelper.prefs!.setString(key, value);
    }
    if (value is bool) {
      return await CachHelper.prefs!.setBool(key, value);
    }
    return await CachHelper.prefs!.setDouble(key, value);
  }
}

class cashHelper extends CachHelper {
  static dynamic getData({required String key}) {
    return CachHelper.prefs!.get(key);
  }
}

class RemoveDataFromPrefs extends CachHelper {
  static Future<bool> removeData({required String key}) {
    return CachHelper.prefs!.remove(key);
  }
}

class ClearDataFromPrefs extends CachHelper {
  static Future<bool> clearData() {
    return CachHelper.prefs!.clear();
  }
}
