import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_qr/common/models/store_model.dart';

class AuthStore {
  static final _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static void save(StoreModel storeModel) async {
    final value = jsonEncode(storeModel.toMap());
    await _storage.write(key: 'auth', value: value);
  }

  static Future<StoreModel?> read() async {
    final auth = await _storage.read(key: 'auth');
    return auth != null ? StoreModel.fromJson(json.decode(auth)) : null;
  }

  static void remove() async {
    await _storage.delete(key: 'auth');
  }
}

AndroidOptions _getAndroidOptions() =>
    const AndroidOptions(encryptedSharedPreferences: true);
