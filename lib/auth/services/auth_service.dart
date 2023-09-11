import 'package:app_qr/auth/infrastructure/models/login_model.dart';
import 'package:app_qr/common/models/store_model.dart';

import '../infrastructure/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  Future<StoreModel> login(LoginModel loginModel) async {
    return _authRepository.login(loginModel);
  }

  void logout() {
    _authRepository.logout();
  }
}