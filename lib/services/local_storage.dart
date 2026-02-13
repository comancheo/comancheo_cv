import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
enum StorageKeys {
  deviceUUID,
  userCredentials,
  email,
  isVerified,
}
class LocalStorageService {
  Future<LocalStorageService> init() async {
    await initLocalStorage();
    return this;
  }

  void saveData(StorageKeys key, dynamic value) {
    debugPrint('Saving data for key ${key.toString()}: $value');
    localStorage.setItem(key.toString(), jsonEncode(value));
    debugPrint('Saved data for key ${key.toString()}: $value ${getData(key)}');
  }

  dynamic getData(StorageKeys key) {
    final jsonString = localStorage.getItem(key.toString());
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

}