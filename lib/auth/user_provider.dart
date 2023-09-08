import 'package:flutter/material.dart';
import 'package:app_qr/common/models/store_model.dart';

class UserProvider with ChangeNotifier {
  UserProvider(this._isLogged) {
    _id = _role = null;
  }

  UserProvider.fromStore(StoreModel store) {
    _isLogged = true;
    _id = store.id!;
    _role = store.role!;
  }

  late bool _isLogged;
  late String? _id;
  late String? _role;

  bool get isLogged => _isLogged;
  String get role => _role!;
  String get id => _id!;

  Future<void> setIsLogged({required bool isLogged}) async {
    _isLogged = isLogged;
    notifyListeners();
  }

  Future<void> login({required StoreModel store}) async {
    _isLogged = true;
    _id = store.id!;
    _role = store.role!;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLogged = false;
    _id = _role = null;
    notifyListeners();
  }
}
