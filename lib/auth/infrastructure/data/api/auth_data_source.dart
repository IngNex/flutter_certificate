import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:app_qr/auth/infrastructure/models/auth_model.dart';
import 'package:app_qr/auth/infrastructure/models/login_model.dart';
import 'package:app_qr/common/models/api_error_model.dart';
import 'package:app_qr/common/models/store_model.dart';
import 'package:app_qr/common/utils/auth_store.dart';
import 'package:app_qr/common/utils/http_helper.dart';

class AuthDataSource extends HttpHelper {
  AuthDataSource({apiUrl = 'auth'}) : super(apiUrl);

  Future<StoreModel> login(LoginModel login) async {
    final Response? result =
        await this.post('/login', json.encode(login.toMap()));

    if (result == null) {
      throw ErrorDescription('Hubo un error');
    }

    if (result.statusCode != HttpStatus.created) {
      final errorBody = json.decode(result.body);
      ApiErrorModel error = ApiErrorModel.fromJson(errorBody);
      print('error'+ error.toString());
      return Future.error(error);
    }

    final jsonResponse = json.decode(result.body);
    print('holaaaaaaaaaa'+jsonResponse);
    AuthModel authModel = AuthModel.fromJson(jsonResponse);
    StoreModel store = StoreModel(
      authModel.user!.id,
      authModel.user!.username,
      authModel.token,
      authModel.user!.role,
    );
    AuthStore.save(store);

    return store;
  }

  void logout() {
    AuthStore.remove();
  }
}
