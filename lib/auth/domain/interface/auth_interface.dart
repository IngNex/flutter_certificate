import 'package:qr/auth/infrastructure/models/login_model.dart';
import 'package:qr/common/models/store_model.dart';

abstract class AuthInterface {
  Future<StoreModel> login(LoginModel login);
  void logout();
}
