import 'dart:convert';

import 'package:localstorage/localstorage.dart';
enum StorageKeys {
  deviceUUID,
  email,
  isVerified,
}
class LocalStorageService {
  Future<LocalStorageService> init() async {
    await initLocalStorage();
    return this;
  }

  void saveData(StorageKeys key, dynamic value) {
    localStorage.setItem(key.toString(), jsonEncode(value));
  }

  dynamic getData(StorageKeys key) {
    final jsonString = localStorage.getItem(key.toString());
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

}