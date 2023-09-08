import 'package:app_qr/auth/domain/interface/auth_interface.dart';
import 'package:app_qr/auth/infrastructure/models/login_model.dart';
import 'package:app_qr/common/models/store_model.dart';

import '../data/api/auth_data_source.dart';

class AuthRepository implements AuthInterface {
  final AuthDataSource _authDataSource;

  AuthRepository(this._authDataSource);

  @override
  Future<StoreModel> login(LoginModel login) async {
    return await _authDataSource.login(login);
  }

  @override
  void logout() {
    _authDataSource.logout();
  }
}
